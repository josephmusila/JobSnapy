import 'package:flutter/material.dart';


import '../config/colors.dart';


class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: "Job",
        style: TextStyle(
          color: AppColors.appMainColor1,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
          text: "Snap",
          style: TextStyle(
            color: AppColors.appPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          )
        ]
      ),

    );
  }
}
