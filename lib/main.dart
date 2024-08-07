import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:meal_mate/provider/personal_data.dart';
import 'package:meal_mate/screens/MainPage.dart';
import 'package:meal_mate/screens/error_page.dart';
import 'package:meal_mate/screens/first_page_view.dart';
import 'package:meal_mate/screens/mainPage_loader.dart';
import 'package:meal_mate/screens/no_connection.dart';
import 'package:meal_mate/services/analytics_services.dart';
import 'package:meal_mate/services/locator.dart';
import 'package:meal_mate/widgets/background_animated.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void setupLocator() {
  locator.registerSingleton<AnalyticsService>(AnalyticsService());
}

AnalyticsService _analyticsService = locator<AnalyticsService>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  setupLocator();
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return const ErrorWidgetDisplay();
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PersonnalDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  // NetworkController.initNetworkController();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool isConnected = true;
  bool isCheckingConnectivity = true;

  @override
  void initState() {
    super.initState();
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      setState(() {
        isConnected = (status == InternetStatus.connected);
        isCheckingConnectivity = false;
      });
    });
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    bool result = await InternetConnection().hasInternetAccess;
    setState(() {
      isConnected = result;
      isCheckingConnectivity = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GetMaterialApp(
          navigatorKey: navigatorKey,
          useInheritedMediaQuery: true,
          navigatorObservers: [_analyticsService.getAnalyticsObserver()],
          localizationsDelegates: const [
            DefaultWidgetsLocalizations.delegate,
          ],
          // theme: themeProvider.isDarkMode ? dark_mode : light_mode,
          debugShowCheckedModeBanner: false,
          routes: const {},
          home: StreamBuilder<InternetStatus>(
            stream: InternetConnection().onStatusChange,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MainPageLoader();
              }

              bool isConnected = snapshot.data == InternetStatus.connected;
              if (FirebaseAuth.instance.currentUser == null) {
                return isConnected
                    ? AnimatedSplashScreen(
                        animationDuration: const Duration(milliseconds: 1500),
                        backgroundColor: const Color(0xFF5A56FB),
                        curve: Curves.easeIn,
                        splashTransition: SplashTransition.scaleTransition,
                        splash: Transform.scale(
                          scale: 3,
                          child: Hero(
                            tag: 'switch',
                            child: Lottie.asset('assets/lotties/1.json',
                                repeat: false,
                                animate: true,
                                frameRate: const FrameRate(144)),
                          ),
                        ),
                        pageTransitionType: PageTransitionType.fade,
                        nextScreen: MyPageViewPresentation(),
                      )
                    : NoConnectionPage(
                        onRetry:
                            _checkConnectivity); //MyPageViewPresentation();
              } else {
                return isConnected
                    ? const MainPage()
                    : NoConnectionPage(onRetry: _checkConnectivity);
              }
            },
          ),
        ),
      ),
      /*
            Builder(builder: (context) {
            Future.delayed(Duration.zero, () {
              ConnectivityChecker().getConnectivity(context);
            });
            return FirebaseAuth.instance.currentUser == null
                ? SelectLanguage()
                : MainPage();
            }),
            */
    );
  }
}
