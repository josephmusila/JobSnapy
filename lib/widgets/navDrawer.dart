import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:jobsnap/screens/chatScreen.dart';
import 'package:jobsnap/widgets/topShape.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import '../screens/about.dart';
import '../screens/abuseReportScreen.dart';
import '../screens/bugReport.dart';
import '../screens/customerCare.dart';
import '../screens/homescreen.dart';
import '../screens/loginPage.dart';
import '../screens/notificationScreen.dart';
import '../screens/profile.dart';
import '../screens/registerPage.dart';
import '../services/abuseReport.dart';
import 'navItem.dart';

class NavDrawer extends StatelessWidget {
  UserModel? user;

  NavDrawer([this.user]);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.appMainColor2,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // topRight: Radius.circular(10),
            // bottomRight: Radius.circular(10),
            ),
      ),
      child: SafeArea(
        child: Container(
          // margin: const EdgeInsets.only(t,),
          height: double.maxFinite,

          width: double.maxFinite,
          color: AppColors.appMainColor2,
          child: ListView(
            children: [
              Container(
                height: 150,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 200),
                      painter: CurvedPainter(),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          user == null
                              ? "Welcome"
                              : "Hello ${user!.firstName.capitalize()}.",
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.appTextColor3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              NavItem(
                title: "Home",
                widget: HomeScreen(user),
                icon: Icons.home,
              ),
              // NavItem(title: "My Profile", widget: user == null? LoginPage():ProfileScreen(user as UserModel),icon: Icons.account_circle_outlined),
              NavItem(
                  title: "Register",
                  widget: RegisterPage(),
                  icon: Icons.switch_account_sharp),
              NavItem(
                  title: user == null ? "Login" : "Logout",
                  widget: LoginPage(),
                  icon: user == null ? Icons.login : Icons.logout),
              NavItem(
                title: "Notifications",
                widget: NotificationsScreen(),
                icon: Icons.notifications,
              ),
              NavItem(
                title: "Abuse Report",
                widget: AbuseReport(user),
                icon: Icons.report,
              ),
              NavItem(
                title: "Report a Bug",
                widget: BugReport(),
                icon: Icons.bug_report,
              ),
              NavItem(
                title: "Customer Care",
                widget: CustomerCare(),
                icon: Icons.phone,
              ),
              NavItem(
                title: "About",
                widget: About(user),
                icon: Icons.app_settings_alt_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
