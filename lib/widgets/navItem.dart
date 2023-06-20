import 'package:flutter/material.dart';

import '../config/colors.dart';

class NavItem extends StatelessWidget {
  String title;
  Widget widget;
  IconData icon;

  NavItem({required this.title, required this.widget, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.whiteColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.appTextColor3,
          ),
        ),
        onTap: () {
          // Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return widget;
              },
            ),
          );
        },
      ),
    );
  }
}
