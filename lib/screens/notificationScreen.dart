import 'package:flutter/material.dart';


import '../config/colors.dart';
import '../widgets/errorScreen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // backgroundColor: Colors.transparent,
        backgroundColor: AppColors.appMainColor2,
        // elevation: 0,
        title: const Text("Notifications"),
      ),
      body: Container(
        color: AppColors.whiteColor,
        child: Center(child: ErrorScreen(error: "No New Notifications."),),
      ),

    );
  }
}
