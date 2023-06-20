import 'dart:io';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../config/colors.dart';
import '../widgets/contactsItem.dart';
import '../widgets/snackbar.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Contacts"),
        backgroundColor: AppColors.appMainColor2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.whiteColor,
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            padding: const EdgeInsets.only(top: 5),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 70,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    color: AppColors.whiteColor1,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const Center(
                  child: Text(
                    "You Can Now Reach Us From Everywhere",
                    style: TextStyle(fontSize: 16, color: AppColors.appMainColor1),
                  ),
                ),
              ),
              Row(
                children: [

                  Expanded(
                      child: ContactsItem(

                        icon: Icons.phone,
                        color: Colors.green,
                        description: "Call us",
                        callback: () async {
                          launch("tel://0745787487");
                        },
                      )),
                  Expanded(
                      child: ContactsItem(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    description: "Like our Page",
                    callback: () async {
                      String fbProtocolUrl;
                      if (Platform.isIOS) {
                        fbProtocolUrl = 'fb://page/104299865990411';
                      } else {
                        fbProtocolUrl = 'fb://page/104299865990411';
                      }
                      String fallbackUrl = 'https://www.facebook.com/JobSnap';

                      try {
                        Uri fbBundleUri = Uri.parse(fbProtocolUrl);
                        var canLaunchNatively = await canLaunchUrl(fbBundleUri);
                        if (canLaunchNatively) {
                          launchUrl(fbBundleUri);
                        } else {
                          await launchUrl(Uri.parse(fallbackUrl),
                              mode: LaunchMode.externalApplication);
                        }
                      } catch (e, st) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Utils.displayToast("Unable to open FACEBOOK service",
                              AppColors.appMainColor2),
                        );
                      }
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ContactsItem(
                    icon: Icons.messenger,
                    color: Colors.green,
                    description: "Whatsapp",
                    callback: () async {
                      // var contact = "+254745787487";
                      // var androidUrl = "whatsapp://send?phone=$contact&text=Hello";
                      // var iosUrl = "https://whatsapp://send?phone=$contact&text=Hello";
                      var url =
                          Uri.parse("https://wa.me/+254751218745?text=Hello");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Utils.displayToast("Unable to open WhatsApp service",
                              AppColors.appMainColor2),
                        );
                      }
                    },
                  )),
                  // Expanded(
                  //     child: ContactsItem(
                  //   icon: Icons.phone,
                  //   color: Colors.green,
                  //   description: "Call us",
                  //   callback: () async {
                  //     launch("tel://0745787487");
                  //   },
                  // )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ContactsItem(
                      icon: Icons.message,
                      color: Colors.black,
                      description: "Send a message",
                      callback: () async {
                        var url = Uri.parse("sms:0745787487");

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            Utils.displayToast("Unable to open SMS service",
                                AppColors.appMainColor2),
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                      child: ContactsItem(
                        icon: Icons.mail,
                        color: Colors.red,
                        description: "Email us \n info@vivatechy.com",
                        callback: () async {
                          var url = Uri.parse("mailto:info@vivatechy.com");

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              Utils.displayToast("Unable to open MAIL service",
                                  AppColors.appMainColor2),
                            );
                          }
                        },
                      )),
                  // Expanded(
                  //   child: ContactsItem(
                  //     icon: Icons.code,
                  //     color: AppColors.appMainColor2,
                  //     description: "visit our website",
                  //     callback: () async {
                  //       var url = Uri.parse("https://vivatechy.com");
                  //
                  //       if (await canLaunchUrl(url)) {
                  //         await launchUrl(url);
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           Utils.displayToast("Unable to open vivatechy.com ",
                  //               AppColors.appMainColor2),
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 70,
                width: double.maxFinite,
                decoration:  BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1),
                    color: AppColors.whiteColor1,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(
                  child: Text(
                    "Always There to Serve You",
                    style: TextStyle(fontSize: 16, color: AppColors.appMainColor1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
