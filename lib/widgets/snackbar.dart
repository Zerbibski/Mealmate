import 'package:flutter/material.dart';
import 'package:meal_mate/utils/styles.dart';

void customSnackBar(String message, Color color, BuildContext context) {
  final snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // margin: EdgeInsets.all(30),
    padding: const EdgeInsets.all(20),
    content: Text(
      message,
      style: normalBoldWhiteStyle.copyWith(fontSize: 16),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
