import 'package:flutter/material.dart';
import 'package:jobsnap/models/jobsModel.dart';
import 'package:jobsnap/widgets/snackbar.dart';

import 'package:url_launcher/url_launcher.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import 'package:jobsnap/models/userModel.dart';

class ApplicantsWidget extends StatelessWidget {
  List<PostedBy> applicants;

  ApplicantsWidget({required this.applicants});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
      applicants.length,
      (index) => Container(
        margin: const EdgeInsets.only(bottom: 5, left: 2, right: 2),
        decoration:  BoxDecoration(
          color: AppColors.appMainColor2.withOpacity(0.7),
        ),
        padding: const EdgeInsets.only(left: 0, bottom: 0),
        height: 80,
        width: double.maxFinite,
        child: ListTile(
          leading: Text(
            "${index + 1}.",
            style: const TextStyle(color: Colors.white),
          ),
          title: Text(
            "${applicants[index].firstName} ${applicants[index].lastName}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          subtitle: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            // padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      launch("tel://${applicants[index].phone}");
                    },
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    )),
                IconButton(
                    onPressed: () async{
                      var url = Uri.parse("sms:${applicants[index].phone}");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Utils.displayToast("Unable to open SMS service",
                              AppColors.appMainColor2),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.message,
                      color: Colors.white,
                    )),

                Text(
                  applicants[index].phone,
                  style: const TextStyle(
                    height: 1.5,
                    color: AppColors.appTextColor3,
                  ),
                ),
                // Text(
                //   applicants[index].email,
                //   style: const TextStyle(
                //     height: 1.5,
                //     color:AppColors.appTextColor2,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
