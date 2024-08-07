import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomPageTransition {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static void smoothPageTransition(
    BuildContext context,
    Widget page,
    String eventName, {
    String direction = 'right',
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    final uid = _auth.currentUser?.uid ?? '';

    Offset begin;
    switch (direction) {
      case 'up':
        begin = Offset(0.0, 1.0);
        break;
      case 'down':
        begin = Offset(0.0, -1.0);
        break;
      case 'left':
        begin = Offset(1.0, 0.0);
        break;
      case 'right':
      default:
        begin = Offset(1.0, 0.0);
        break;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: duration, // Add the duration here
      ),
    ).then((_) {
      if (eventName.isNotEmpty) {
        _analytics.logEvent(
          name: eventName,
          parameters: {
            'Client_ID': uid,
          },
        );
      }
    });
  }
}
