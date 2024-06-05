import 'package:flutter/material.dart';
import 'package:jobsnap/screens/adminPanel.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import '../widgets/aboutWidget.dart';

class About extends StatelessWidget {
  UserModel? user;
  About([this.user]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.appMainColor2,
        title: const Text("About App"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          // image: DecorationImage(
          //   image: AssetImage("img/bakg.jpg",),
          //       fit: BoxFit.cover
          // )
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
          child: Card(
            color: AppColors.whiteColor,
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.9,
              // height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "JobSnap App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  AboutWidget(title: "App Version", value: "1.0.3"),
                  AboutWidget(title: "Release Date", value: "20/06/2023"),
                  AboutWidget(title: "Developed At", value: "GenCode"),
                  AboutWidget(title: "Website", value: "vivatechy.com"),
                  AboutWidget(title: "Platform", value: "Android/IOS"),
                  AboutWidget(title: "Call", value: "+254745787487"),
                  const Divider(
                    height: 3,
                    color: AppColors.appMainColor1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextButton(
                      onPressed: () {
                        user == null || user!.isSuperUser == false
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Only Admins Allowed",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                  dismissDirection: DismissDirection.horizontal,
                                  behavior: SnackBarBehavior.fixed,
                                ),
                              )
                            : Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return AdminPanel(user);
                              }));
                      },
                      child: const Text(
                        "Admin Panel",
                        style: TextStyle(
                            fontSize: 20, color: AppColors.appPrimaryColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
