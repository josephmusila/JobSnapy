import 'package:flutter/material.dart';


import '../config/colors.dart';
import '../widgets/aboutWidget.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 300,
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
                  AboutWidget(title: "App Version",value: "1.0.3"),
                  AboutWidget(title: "Release Date",value: "20/06/2023"),
                  AboutWidget(title: "Developed At",value: "GenCode"),
                  AboutWidget(title: "Website",value: "vivatechy.com"),
                  AboutWidget(title: "Platform",value: "Android/IOS"),
                  AboutWidget(title: "Call",value: "+254745787487"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
