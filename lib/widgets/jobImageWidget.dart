import 'package:flutter/material.dart';
import 'package:jobsnap/config/colors.dart';
import 'package:jobsnap/models/jobsModel.dart';

import '../models/userModel.dart';
import '../screens/jobDetail.dart';

class JobImageWidget extends StatelessWidget {
  JobsModel jobsModel;
  UserModel? user;

  JobImageWidget(this.jobsModel,[this.user]);

  String checkTime(DateTime date) {
    DateTime posted = date;

    DateTime enDTime = DateTime.now();

    Duration lapsed = enDTime.difference(posted);

    var hours = lapsed.inHours % 24;
    var mins = lapsed.inMinutes % 60;

    if (lapsed.inHours == 0) {
      return "$mins mins ago";
    } else if (lapsed.inDays == 0) {
      return "$hours hrs $mins mins ago";
    } else {
      return "${lapsed.inDays} ${lapsed.inDays == 1 ? "day" : "days"} $hours hrs $mins mins ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                JobDetail(jobsModel,user),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (_, a, __, c) => FadeTransition(
              opacity: a,
              child: c,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,),
        child: Card(
          color: AppColors.whiteColor1,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 150,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: user == null
                          ? AppColors.appTextColor2
                          .withOpacity(0.1)
                          : user!.id ==
                          jobsModel
                              .postedBy.id
                          ? AppColors.appPrimaryColor
                          .withOpacity(0.5)
                          : AppColors.appTextColor2
                          .withOpacity(0.5),
                      radius: 25,
                      child: Text(
                        "${jobsModel.id}",
                        style: const TextStyle(
                          color: AppColors.appTextColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Image.network(
                      jobsModel.poster as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${jobsModel.postedBy.firstName} ${jobsModel.postedBy.lastName}",
                        style: const TextStyle(color: AppColors.appTextColor1,fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 5),
                        color: AppColors.whiteColor,
                        child: Text(
                          checkTime(jobsModel.datePosted,), style: const TextStyle(color: AppColors.appMainColor2,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
