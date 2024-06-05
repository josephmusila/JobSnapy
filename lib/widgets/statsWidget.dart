import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  String title;
  IconData icon;
  Color iconColor;
  int count;

  StatsWidget({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shadowColor: iconColor,
        child: Container(
          padding: const EdgeInsets.all(10),
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),

                child:  Icon(
                  icon,
                  size: 40,
                  color: iconColor,
                ),
              ),
              Container(
                // color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  child:  Text(
                    count.toString(),
                    style:  TextStyle(fontSize: 22,color: iconColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
