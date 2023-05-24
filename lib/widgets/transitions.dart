import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder{
  @override

  Widget buildTransitions<T>(
    PageRoute<T> route,
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,

  ){
    double begin  = 0;
    double end =0;
    var curve  = Curves.easeOut;


    final tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));

    final scaleAnimation = animation.drive(tween);

    if(route.settings.name == "/"){
      return child;
    
    }

    return ScaleTransition(scale: scaleAnimation,child: child,);
  }
}