import 'package:flutter/material.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget? leadingIcon;
  final Widget? suffixIcon;
  final bool? obscureText;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.leadingIcon,
      this.suffixIcon,
      this.obscureText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: normalBlackStyle.copyWith(color: black),
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: widget.leadingIcon ?? const Icon(Icons.edit),
        suffixIcon: widget.suffixIcon ?? const SizedBox(),
        hintText: widget.hintText,
        hintStyle: normalBlackStyle.copyWith(color: black),
        filled: true,
        fillColor: white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
