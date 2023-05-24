import 'package:flutter/material.dart';
import 'package:jobsnap/widgets/quotesWidget.dart';



import '../config/colors.dart';

class LoadingScreen extends StatelessWidget {
  String message;

  LoadingScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: AppColors.whiteColor,
      child: Center(
        child: Container(
          height: 200,
          width: 300,
          decoration: const BoxDecoration(
              color: AppColors.appMainColor2,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                const CircularProgressIndicator(

                  strokeWidth: 7,
                  backgroundColor: AppColors.appMainColor2,
                  color: AppColors.appPrimaryColor,
                ),
                Text(
                  message,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.pink
                  ),
                ),
                QuotesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
