import 'package:flutter/material.dart';

import '../config/colors.dart';


class AboutWidget extends StatelessWidget {
  String title;
  String value;

  AboutWidget({required this.title, required this.value});

  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.appTextColor1,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SelectableText(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
