import 'package:flutter/material.dart';

import '../config/colors.dart';


class ErrorScreen extends StatelessWidget {
  String error;

  ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return

       Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.whiteColor1,
        child: Center(
          child: Card(
            elevation: 4,
            child: Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor1,
                  // borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: Text(
                  error,
                  style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.appTextColor1
                  ),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
