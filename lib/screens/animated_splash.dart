import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meal_mate/utils/colors.dart';

class AnimatedSplashBuilder extends StatefulWidget {
  final Widget child;
  const AnimatedSplashBuilder({Key? key, required this.child})
      : super(key: key);

  @override
  State<AnimatedSplashBuilder> createState() => _AnimatedSplashBuilderState();
}

class _AnimatedSplashBuilderState extends State<AnimatedSplashBuilder>
    with TickerProviderStateMixin {
  late AnimationController _controllerEasy;
  late AnimationController _controllerFast;

  bool isTransitionFinished = false;

  @override
  void initState() {
    super.initState();

    _controllerEasy = AnimationController(
      vsync: this,
      value: 0,
    );
    _controllerFast = AnimationController(
      vsync: this,
      value: 0,
    );

    // Ajoutez un listener pour reconstruire le widget lorsque l'animation progresse
    _controllerEasy.addListener(() {
      if (_controllerEasy.isCompleted) {
        setState(() {
          isTransitionFinished = true;
        });
      }
    });

    _controllerEasy.animateTo(
      1.0,
      duration: const Duration(milliseconds: 3700),
      curve: Curves.easeInExpo,
    );
    _controllerFast.animateTo(
      1.0,
      duration: const Duration(milliseconds: 3700),
      curve: Curves.easeInExpo,
    );
  }

  @override
  void dispose() {
    _controllerEasy.dispose();
    _controllerFast.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        isTransitionFinished == false
            ? AnimatedBuilder(
                animation: _controllerEasy,
                builder: (context, child) {
                  return Opacity(
                    opacity: isTransitionFinished ? 0 : 1,
                    child: Container(
                      //duration: Duration(seconds: 2),
                      color: mainColor,
                      //curve: Curves.easeInOut,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            color: mainColor,
                            child: Center(
                              child: Opacity(
                                  opacity: isTransitionFinished ? 0 : 1,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/SplashAnimationAndText.json',
                                      repeat: false,
                                      animate: true,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
