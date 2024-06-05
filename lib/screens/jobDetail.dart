import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ads/bannerAd.dart';
import '../config/colors.dart';
import '../cubits/comments/commentsCubits.dart';
import '../logic/commentsSectionLogic.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/customWidgets.dart';
import '../widgets/googleads.dart';
import '../widgets/loadingScreen.dart';
import '../widgets/navDrawer.dart';
import '../widgets/snackbar.dart';
import 'abuseReportScreen.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

import 'editJob.dart';

class JobDetail extends StatefulWidget {
  JobsModel job;
  UserModel? user;

  JobDetail(this.job, [this.user]);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  var isLoading = false;
  var isPressed = false;
  var applicationLoader = false;
  var comments = TextEditingController();
  JobService jobService = JobService();
  final _formKey = GlobalKey<FormState>();
  bool canEdit=false;


  @override
  void initState() {
    // TODO: implement initState
    // print("iuser in details is ${widget.user!.email}");
    checkTime();
    isEligibleToEdit();
    super.initState();
  }


  String checkTime() {
    DateTime posted = widget.job.datePosted;
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

  void isEligibleToEdit(){
    if( (widget.user != null)  && (widget.user!.id == widget.job.postedBy.id) ){
      canEdit=true;
    }else{
      canEdit=false;
    }

  }

  // final entries=NativeL

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        bottomNavigationBar: GoogleAdBannner(),
        backgroundColor: AppColors.appMainColor2,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).pop();
            },
          ),

          actions: [
            canEdit?IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditJob(
                          user: widget.user as UserModel,
                          job: widget.job,
                        );
                      },
                    ),
                  );
                },
                icon: Icon(Icons.edit))
                : Container(),

            // widget.job.postedBy.id == widget.user!.id ||
            //         widget.user!.isSuperUser == true
            //     ? IconButton(
            //         onPressed: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) {
            //                 return EditJob(
            //                   user: widget.user as UserModel,
            //                   job: widget.job,
            //                 );
            //               },
            //             ),
            //           );
            //         },
            //         icon: Icon(Icons.edit))
            //     : Container()
          ],

          backgroundColor: AppColors.appMainColor2,
          // elevation: 0,
          title: Text(
            "Job Id: ${widget.job.id.toString()}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
        body: BlocProvider(
          create: (context) => CommentsCubit(jobService: jobService),
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
            color: AppColors.whiteColor,
            height: double.maxFinite,
            width: double.maxFinite,
            child: applicationLoader
                ? Container(
                    height: 150,
                    width: double.maxFinite,
                    child: LoadingScreen(message: "Sending application"))
                : ListView(
                    padding: const EdgeInsets.only(top: 10),
                    children: [
                      widget.job.isImage
                          ? Container(
                              // height: 300,
                              color: Colors.red,
                              child: Image.network(
                                widget.job.poster.toString(),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Card(
                              color: Colors.transparent,
                              elevation: 4,
                              child: Container(
                                // height: 200,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AppColors.whiteColor1,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width >
                                              500
                                          ? MediaQuery.of(context).size.width *
                                              0.4
                                          : MediaQuery.of(context).size.width *
                                              0.8,
                                      child: Text(
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        widget.job.jobName as String,
                                        style: const TextStyle(
                                          height: 1.4,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.appTextColor1,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColors.appMainColor2,
                                      height: 1,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width >
                                              500
                                          ? MediaQuery.of(context).size.width *
                                              0.4
                                          : MediaQuery.of(context).size.width *
                                              0.8,
                                      child: SelectableLinkify(
                                        text: widget.job.jobDescription,
                                        style: const TextStyle(
                                          height: 1.4,
                                          fontSize: 14,
                                          color: AppColors.appTextColor1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GoogleAdBannner(),
                                    // BannerAdWidget(),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    // const BannerAdWidget(),
                                    widget.job.qualification != null
                                        ? const Text(
                                            "Qualifications",
                                            style: TextStyle(
                                              color: AppColors.appTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Container(),

                                    const SizedBox(
                                      height: 3,
                                    ),
                                    widget.job.qualification != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    500
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                            child: SelectableLinkify(
                                              text: widget.job.qualification ??
                                                  "Not Provided",
                                              style: const TextStyle(
                                                height: 1.4,
                                                fontSize: 14,
                                                color: AppColors.appTextColor1,
                                              ),
                                            ),
                                          )
                                        : Container(),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const Text(
                                      "Method of Application",
                                      style: TextStyle(
                                        color: AppColors.appTextColor1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width >
                                              500
                                          ? MediaQuery.of(context).size.width *
                                              0.4
                                          : MediaQuery.of(context).size.width *
                                              0.8,
                                      child: SelectableLinkify(
                                        onOpen: (link) async {
                                          var url = Uri.parse(link.url);

                                          if (await canLaunchUrl(url)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              Utils.displayToast(
                                                  "Opening ${link.url} in default app",
                                                  Colors.green),
                                            );
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              Utils.displayToast(
                                                  "Unable to open ${link.url}",
                                                  AppColors.appPrimaryColor),
                                            );
                                          }
                                        },
                                        onTap: () async {},
                                        text: widget.job.applicationMethod ??
                                            "Not Provided",
                                        style: const TextStyle(
                                          height: 1.4,
                                          fontSize: 14,
                                          color: AppColors.appTextColor1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GoogleAdBannner(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Container(
                        height: 200,
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        decoration: const BoxDecoration(
                          // color: AppColors.appMainColor2.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                              // bottomRight: Radius.circular(10),
                              // topRight: Radius.circular(10),
                              // bottomLeft: Radius.circular(10),
                              ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-10, -10),
                                        blurRadius: 30,
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.account_circle_outlined,
                                    color: AppColors.appTextColor2,
                                  ),
                                  Text(
                                    "${widget.job.postedBy.firstName} ${widget.job.postedBy.lastName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColors.appTextColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 5,
                              child: Container(
                                height: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(4, 4),
                                          blurRadius: 15,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-10, -10),
                                          blurRadius: 30,
                                          spreadRadius: 1)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: AppColors.appTextColor2,
                                    ),
                                    Text(
                                      checkTime(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.appTextColor1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 90,
                              left: 5,
                              right: 10,
                              child: Container(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appMainColor1,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      applicationLoader = true;
                                    });
                                    if (widget.user == null) {
                                      setState(() {
                                        applicationLoader = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(Utils.displayToast(
                                              "Please Login to complete application",
                                              AppColors.appPrimaryColor));
                                    } else if (widget.job.postedBy.id ==
                                        widget.user?.id) {
                                      setState(() {
                                        applicationLoader = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(Utils.displayToast(
                                              "Operation not allowed as you are the job owner",
                                              AppColors.appPrimaryColor));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: AppColors.whiteColor,
                                          title: const Text(
                                            "Attention",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: const Text(
                                            "Please Use the Application \nprocedure provided in the job description.\n\n"
                                            "Otherwise the system will sent your contact details to the "
                                            "person who posted the Job.",
                                            style: TextStyle(
                                              color: AppColors.appTextColor1,
                                            ),
                                          ),
                                          actions: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        applicationLoader =
                                                            false;
                                                      });
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      try {
                                                        var response =
                                                            await jobService.applyJob(
                                                                jobId: widget
                                                                    .job.id
                                                                    .toString(),
                                                                userId: widget
                                                                    .user!.id
                                                                    .toString());
                                                        if (response == 200) {
                                                          setState(() {
                                                            applicationLoader =
                                                                false;
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(Utils
                                                                    .displayToast(
                                                                        "Application Sent\nConfirm on Your Profile Page",
                                                                        AppColors
                                                                            .appPrimaryColor));
                                                          });
                                                        } else {
                                                          setState(() {
                                                            applicationLoader =
                                                                false;
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(Utils
                                                                    .displayToast(
                                                                        "Unable to Sent Application\nA network error occurred.",
                                                                        AppColors
                                                                            .appMainColor2));
                                                          });
                                                        }
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(Utils
                                                                .displayToast(
                                                                    e
                                                                        .toString(),
                                                                    AppColors
                                                                        .appPrimaryColor));
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Send Details",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        applicationLoader =
                                                            false;
                                                      });
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Apply"),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              right: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.whiteColor1,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return AbuseReport();
                                      }));
                                    },
                                    child: const Text(
                                      "Report this Job",
                                      style: TextStyle(
                                          color: AppColors.appMainColor1),
                                    ),
                                  ),
                                  Text(
                                    "${widget.job.applicants.length} applicants",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.appTextColor1,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.appMainColor1,
                      ),
                      BlocProvider(
                        create: (context) =>
                            CommentsCubit(jobService: jobService),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(5),
                            boxShadow: isPressed
                                ? const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-10, -10),
                                        blurRadius: 30,
                                        spreadRadius: 1)
                                  ]
                                : null,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                    child: CustomTextField(
                                      controller: comments,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Fill the comment section";
                                        } else {
                                          return null;
                                        }
                                      },
                                      hintText: "write your comment",
                                      hideText: false,
                                      labeltext: "Comment",
                                      maxlines: 1,
                                      onchanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            isPressed = true;
                                          });
                                        } else {
                                          setState(() {
                                            isPressed = false;
                                          });
                                        }
                                      },
                                      textInputType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        size: 30,
                                        color: AppColors.appPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          isPressed = false;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          if (widget.user == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please Login First to post a comment"),
                                                backgroundColor:
                                                    AppColors.appPrimaryColor,
                                                dismissDirection:
                                                    DismissDirection.horizontal,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              isLoading = true;
                                            });
                                            try {
                                              await jobService
                                                  .addComment(
                                                      comment: comments.text,
                                                      jobId: widget.job.id
                                                          .toString(),
                                                      postedBy: widget.user!.id
                                                          .toString())
                                                  .then((value) => setState(
                                                      () => isLoading = false))
                                                  .then((value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Comment Posted",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          backgroundColor:
                                                              Colors.green,
                                                          dismissDirection:
                                                              DismissDirection
                                                                  .horizontal,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .fixed,
                                                        ),
                                                      ))
                                                  .then((value) =>
                                                      comments.text = "");
                                            } on Exception catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text("Connection Error"),
                                                  backgroundColor:
                                                      AppColors.appMainColor1,
                                                  dismissDirection:
                                                      DismissDirection
                                                          .horizontal,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      isLoading
                          ? SizedBox(
                              height: 300,
                              width: double.maxFinite,
                              child: LoadingScreen(message: "Posting.."))
                          : BlocProvider(
                              create: (context) =>
                                  CommentsCubit(jobService: JobService()),
                              child: CommentsLogicScreen(
                                  id: widget.job.id.toString()),
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
