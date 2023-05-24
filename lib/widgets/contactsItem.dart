import 'package:flutter/material.dart';

import '../config/colors.dart';


class ContactsItem extends StatelessWidget {
  IconData icon;
  String description;
  VoidCallback callback;
  Color color;

  ContactsItem(
      {required this.description,
      required this.icon,
      required this.callback,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          color: AppColors.whiteColor1,
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        child: Card(
          color: AppColors.whiteColor,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: color,
                size: 50,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
        
                  color: AppColors.appTextColor1,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
