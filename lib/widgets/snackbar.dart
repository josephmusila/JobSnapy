import 'package:flutter/material.dart';


class Utils{
  static SnackBar displayToast(String message,Color color){
    return  SnackBar(
      // duration: Duration(seconds: 10),
      content: Text(message,style: TextStyle(color: Colors.white),),
      backgroundColor: color,
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,

    );
  }
}