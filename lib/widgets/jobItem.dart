import 'package:flutter/material.dart';
import 'package:jobsnap/models/userModel.dart';

import '../config/colors.dart';
import '../models/jobsModel.dart';
import '../screens/jobDetail.dart';


class JobItem extends StatefulWidget {
  List<JobsModel> searched_list;
  UserModel? user;
  int index;
  VoidCallback callback;
  Color color;

  JobItem(this.searched_list,this.index,this.callback,this.color,[this.user]);

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
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        curve: Curves.decelerate,
        duration: Duration(milliseconds: (widget.index * 10) + 200),
        tween: Tween(begin: -10, end: 0.5),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value * 200 - 100, 0),
            child: Container(
              constraints: const BoxConstraints.expand(height: 120),
              margin:
              const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: InkWell(
                  onTap: widget.callback,
                  // onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageRouteBuilder(
                    //         pageBuilder: (_, __, ___) => JobDetail(
                    //             widget.searched_list[widget.index],
                    //             widget.user),
                    //         transitionDuration:
                    //         Duration(milliseconds: 300),
                    //         transitionsBuilder: (_, a, __, c) =>
                    //             FadeTransition(
                    //               opacity: a,
                    //               child: c,
                    //             )));
                    //
                    // // Navigator.of(context)
                    // //     .push(MaterialPageRoute(builder: (context) {
                    // //   return JobDetail(widget.searched_list[index], widget.user);
                    // // }));
                  // },
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: Colors.white, width: 0.9),
                      color: widget.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5),

                    height: 125,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor: widget.user == null
                                ? AppColors.appTextColor2
                                .withOpacity(0.1)
                                : widget.user!.id ==
                                widget.searched_list[widget.index]
                                    .postedBy.id
                                ? AppColors.appPrimaryColor
                                .withOpacity(0.5)
                                : AppColors.appTextColor2
                                .withOpacity(0.5),
                            radius: 25,
                            child: Text(
                              "${widget.searched_list[widget.index].id}",
                              style: const TextStyle(
                                color: AppColors.appTextColor1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            // margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.searched_list[widget.index].jobName,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: AppColors.appTextColor1,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  widget.searched_list[widget.index]
                                      .jobDescription,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.appTextColor1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.all(5),
                                      decoration:  BoxDecoration(
                                          color: AppColors.whiteColor.withOpacity(0.2),
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  8))),
                                      child: Text(
                                        "Posted: ${widget.checkTime(widget.searched_list[widget.index].datePosted)}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                          AppColors.appPrimaryColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
