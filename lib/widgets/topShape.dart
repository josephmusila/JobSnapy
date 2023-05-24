import 'package:flutter/material.dart';
import 'package:jobsnap/config/colors.dart';

class CurvedPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color=AppColors.appMainColor1;
    paint.style=PaintingStyle.fill;


    var path=Path();
    path.moveTo(0, size.height*0.5);
    path.quadraticBezierTo(size.width*0.25, size.height*0.3, size.width*0.3,size.height*0.5);
    path.quadraticBezierTo(size.width*0.7, size.height*0.2, size.width, size.height*0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
   return false;
  }

}