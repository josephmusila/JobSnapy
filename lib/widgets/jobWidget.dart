import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:jobsnap/widgets/jobItem.dart';

import '../config/colors.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../screens/homescreen.dart';
import '../screens/jobDetail.dart';
import '../services/jobServices.dart';
import 'jobImageWidget.dart';

class JobsWidget extends StatefulWidget {
  List<JobsModel> searched_list;
  UserModel? user;
  final int index;

  JobsWidget(this.searched_list, [this.user, this.index = 0]);

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
  State<JobsWidget> createState() => _JobsWidgetState();
}

class _JobsWidgetState extends State<JobsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  bool _animate = false;
  static bool _isStart = true;

  List<JobsModel> loadedJobList = [];

  @override
  void initState() {
    super.initState();
  }

  JobService jobService = JobService();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.searched_list.length,
        (_, index) {
          if(widget.searched_list[index].isImage==true){
            return JobImageWidget(widget.searched_list[index],widget.user);
          }else{
            return JobItem(widget.searched_list, index, () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      JobDetail(widget.searched_list[index], widget.user),
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(
                    opacity: a,
                    child: c,
                  ),
                ),
              );

              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) {
              //   return JobDetail(widget.searched_list[index], widget.user);
              // }));
            }, AppColors.whiteColor1, widget.user);
          }
          }
      ),
    );
  }
}
