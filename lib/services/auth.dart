import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_mate/screens/background_screen.dart';
import 'package:meal_mate/screens/home.dart';
import 'package:meal_mate/widgets/snackbar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future logout(context) async {
    await _auth.signOut();
    Get.offAll(() => const BackgroundScreen());
  }

  Future loginOlimUser(String email, password, BuildContext context) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      print(user.email);
    } on FirebaseAuthException catch (error) {
      var message = '';
      switch (error.code) {
        case 'user-not-found':
          message = 'IncorectMailorPassword'.tr;
      }
      switch (error.code) {
        case 'too-many-requests':
          message = 'TooManyRequest'.tr;
      }
      switch (error.code) {
        case 'wrong-password':
          message = 'IncorectPassword'.tr;
      }

      print(error.code);
      customSnackBar(message, Colors.red.withOpacity(0.9), context);
    }
  }
}
