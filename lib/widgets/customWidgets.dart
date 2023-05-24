import 'package:flutter/material.dart';

import '../config/colors.dart';


class CustomTextField extends StatefulWidget {
  String labeltext;
  String hintText;
  TextEditingController controller;
  Function(String value) onchanged;
  dynamic validator;
  bool hideText;
  TextInputType textInputType;
  ScrollController? scrollController;
  int maxlines;
  Widget? suffixIcon;

  CustomTextField(
      {required this.labeltext,
      required this.hintText,
      required this.controller,
      required this.onchanged,
      required this.validator,
      required this.hideText,
      required this.maxlines,
      this.scrollController,
        this.suffixIcon,
      required this.textInputType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxlines,
      validator: widget.validator,
      onChanged: widget.onchanged,
      controller: widget.controller,
      obscureText: widget.hideText,
      keyboardType: widget.textInputType,
      style: const TextStyle(
        color: AppColors.appTextColor1,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        filled: true,
        fillColor: Colors.black12,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labeltext,
        hintText: widget.hintText,

        labelStyle: const TextStyle(
          color: AppColors.appTextColor1,
          fontSize: 16
        ),
        hintStyle: const TextStyle(
          color: AppColors.appAccentColor,
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              6.0,
            ),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color:Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              6.0,
            ),
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appTextColor3.withOpacity(0.2), width: 1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              6.0,
            ),
          ),
        ),
      ),
    );
  }
}
