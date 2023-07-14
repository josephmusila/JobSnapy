import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:jobsnap/config/colors.dart';


import '../config/quotes.dart';
class QuotesWidget extends StatelessWidget {

  var messages = Quotes().getQuotes();

  String getRandomMessage(){
    Random random = new Random();
    int randomNumber=random.nextInt(messages.length);
    
    return messages[randomNumber];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColors.whiteColor1,
        height: 60,
        child: AnimatedTextKit(
          animatedTexts:List.generate(messages.length, (index) {
            return  RotateAnimatedText(getRandomMessage(),
                textAlign: TextAlign.center,
                textStyle:const TextStyle(
              fontSize: 16,
              color: AppColors.appTextColor1,
              fontWeight: FontWeight.w400,

            ));
          }),
          displayFullTextOnTap: true,
          repeatForever: true,
          isRepeatingAnimation: true,
          totalRepeatCount: 30,
          pause: const Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}