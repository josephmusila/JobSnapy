import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jobsnap/screens/homescreen.dart';
import 'package:jobsnap/screens/registerPage.dart';
import 'package:jobsnap/widgets/transitions.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:upgrader/upgrader.dart';

import 'ad_helper.dart';
import 'config/colors.dart';

void main()  {

  WidgetsFlutterBinding.ensureInitialized();
   MobileAds.instance.initialize();
  Paint.enableDithering = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.appMainColor2,
      debugShowCheckedModeBanner: false,
      title: 'JobSnap',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        // pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android:CustomPageTransitionBuilder()}),
        brightness: Brightness.light,
        // accentColor: AppColors.appPrimaryColor,
        backgroundColor: AppColors.appMainColor2,
        primarySwatch: Colors.deepPurple,
      ),
      // home: HomeScreen(),
      home: HomeScreen(),
    );
  }
}
