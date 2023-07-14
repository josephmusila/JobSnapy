// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/models/notificationsModel.dart';

import '../config/colors.dart';


class CustomImageSlider extends StatefulWidget {
    List<NotificationsModel> notifications;

    CustomImageSlider({required this.notifications});
  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
              // color: Colors.red
         gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

             // stops: [0, 0.2, 0.8, 1],
                  colors:  const [
                    AppColors.appMainColor2,
                    // AppColors.appMainColor2,
                    AppColors.whiteColor,
                    // AppColors.appMainColor1,
                  ]
                 )
      ),
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlayCurve: Curves.easeIn,
          onScrolled: (value){},
          height: 200,
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: List.generate(
          widget.notifications.length,
          // 4,
          (index) {
            return Card(
              elevation: 3,
              color: AppColors.appMainColor1,
              child: Container(
                height: 300,
                margin: EdgeInsets.only(top: 0, left: 10,bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor1.withOpacity(0),
                  //   gradient: LinearGradient(colors: const [
                  //     AppColors.appMainColor1,
                  //     AppColors.appMainColor2,
                  //     AppColors.appMainColor1,
                  //   ]),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                  
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[

                      Positioned(
                        bottom: 15.0,
                        left: 10.0,
                        right: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            // color: AppColors.appMainColor1.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            widget.notifications[index].notification,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.appTextColor3,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
