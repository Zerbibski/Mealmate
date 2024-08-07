import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:meal_mate/screens/MainPage.dart';
import 'package:meal_mate/services/auth.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/widgets/CustomTextField.dart';
import 'package:meal_mate/widgets/LargeButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordVisible = true;
  bool loading = false;
  final AuthService _authService = AuthService();

  _saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email != null && email.isNotEmpty) {
      setState(() {
        _emailController.text = email;
      });
    }
  }

  passwordVisibilityToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      child: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
        size: 22,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getEmail(); // Récupérer l'e-mail enregistré lors de l'initialisation de l'écran
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: loading ? 0.4 : 1,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: transparent,
              body: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Text(
                        'MEAL',
                        style: bigBoldWhiteOmnes
                            .copyWith(color: darkBlue, shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.5.w, 1.5.h),
                            blurRadius: 2,
                            color: const Color.fromARGB(255, 125, 181, 255),
                          ),
                        ]),
                      ),
                      Text(
                        'MATE',
                        style: bigBoldWhiteOmnes.copyWith(
                            color: const Color.fromARGB(255, 125, 181, 255),
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.5.w, 1.5.h),
                                blurRadius: 2,
                                color: const Color.fromARGB(255, 34, 33, 112),
                              ),
                            ]),
                      ),
                      Gap(30.h),
                      Text(
                        "Let's Sign In",
                        style: bigBoldWhiteOmnes.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Gap(30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                          leadingIcon: const Icon(Icons.mail),
                        ),
                      ),
                      Gap(15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: CustomTextField(
                          hintText: 'Password',
                          controller: _passwordController,
                          leadingIcon: const Icon(Icons.lock),
                          obscureText: isPasswordVisible,
                          suffixIcon: passwordVisibilityToggle(),
                        ),
                      ),
                      Gap(15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Recover password",
                              style: normalBoldWhiteStyle.copyWith(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Omnes'),
                            ),
                          ],
                        ),
                      ),
                      Gap(30.h),
                      LargeButton(
                        text: 'Classic Sign In',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (_key.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            var email = _emailController.text;

                            var password = _passwordController.text;
                            _saveEmail(_emailController.text);

                            await _authService.loginOlimUser(
                                email, password, context);

                            if (_auth.currentUser != null) {
                              setState(() => loading = true);

                              Get.offAll(() => const MainPage(),
                                  transition: Transition.cupertino);
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        width: 320.w,
                        inkColor: const Color.fromARGB(255, 34, 33, 112),
                      ),
                      Gap(4.h),
                      LargeButton(
                        text: 'Sign In With Google',
                        onTap: () {},
                        width: 320.w,
                        color: white,
                        inkColor: const Color.fromARGB(255, 125, 181, 255),
                        style: normalBlackBoldStyle,
                        leading: Image.asset(
                          'assets/logo/google.png',
                          height: 25.h,
                        ),
                      ),
                      Gap(4.h),
                      LargeButton(
                          text: 'Sign In With Facebook',
                          onTap: () {},
                          width: 320.w,
                          color: const Color(0xFF1877F2),
                          inkColor: const Color.fromARGB(255, 243, 243, 243),
                          style: normalBlackBoldStyle.copyWith(color: white),
                          leading: const Icon(
                            FontAwesomeIcons.facebook,
                            color: white,
                          )),
                      const Spacer(),
                      Text(
                        "Don't have an account?",
                        style: normalBoldWhiteStyle.copyWith(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Omnes',
                            fontSize: 17.sp),
                      ),
                      Gap(4.h),
                      LargeButton(
                        text: 'Sign Up',
                        onTap: () {},
                        width: 320.w,
                        inkColor: const Color.fromARGB(255, 34, 33, 112),
                      ),
                      const Gap(20)
                    ],
                  ),
                ),
              )),
        ),
        loading
            ? const Center(
                child: CircularProgressIndicator(
                color: black,
              ))
            : const SizedBox()
      ],
    );
  }
}
/*if (_isLoading)
          const Center(
              child: CircularProgressIndicator(
            color: white,
          ))*/
