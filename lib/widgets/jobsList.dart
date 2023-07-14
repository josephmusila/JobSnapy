import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/ads/bannerAd.dart';
import 'package:jobsnap/cubits/Notifications/notificationCubit.dart';
import 'package:jobsnap/services/notificationService.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../ad_helper.dart';
import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../logic/adsSliderLogic.dart';
import '../logic/jobsLogic.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../screens/jobDetail.dart';
import '../screens/loginPage.dart';
import '../screens/mediumScreens.dart';
import '../screens/newjob.dart';
import '../screens/profile.dart';
import 'adsSlider.dart';
import 'customWidgets.dart';
import 'errorScreen.dart';
import 'jobWidget.dart';
import 'loginWidget.dart';
import 'navDrawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class JobList extends StatefulWidget {
  List<JobsModel> jobs;
  UserModel? user;

  JobList(this.jobs, [this.user]);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  var search = TextEditingController();


  //used searched_list in widgets for it to respond to search method
  List<JobsModel> searched_list = [];
  @override
  void initState() {

    // initBannerAd();
    searched_list = widget.jobs;
    
    // UnityAds.init(gameId: "5325822");
    super.initState();
  }

  double getSizes(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: NavDrawer(widget.user),
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton.extended(
        
          backgroundColor: AppColors.appMainColor1,
          foregroundColor: Colors.black,
          splashColor: Colors.deepOrange,
          hoverElevation: 5,
          elevation: 5,
          onPressed: () {
            if (widget.user == null) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text(
              //       "Login First to Post a Job",
              //       style: TextStyle(color: AppColors.appTextColor3),
              //     ),
              //     backgroundColor: AppColors.appPrimaryColor,
              //     dismissDirection: DismissDirection.horizontal,
              //     behavior: SnackBarBehavior.floating,
              //   ),
              // );
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor1,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: LoginWidget(),
                    );
                  });
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddJob(widget.user);
                  },
                ),
              );
            }
          },
          label: const Text(
            "Post A Job",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      // body: getSizes(context) > 500
      //     ? MediumScreen(widget.jobs, widget.user)
        body  : CustomScrollView(
              slivers: [
                SliverAppBar(

                  elevation: 5,
                  backgroundColor: AppColors.appMainColor2,
                  actions: [
                    Container(
                      margin:
                          const EdgeInsets.only(right: 10, left: 10, top: 0),
                      padding: const EdgeInsets.only(
                          right: 5, left: 0, top: 1, bottom: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // border: Border.all(color: Colors.white10),

                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (widget.user == null) {
                                    showModalBottomSheet(
                                        context: context,
                                        elevation: 5,
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            width: double.maxFinite,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20))),
                                            child: LoginWidget(),
                                          );
                                        });
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ProfileScreen(
                                          widget.user as UserModel,
                                          widget.jobs);
                                    }));
                                  }
                                },
                                icon: const Icon(
                                  Icons.account_circle_outlined,
                                  size: 40,
                                  color: Colors.white,
                                )),
                            Positioned(
                              top: 12,
                              right: 5,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: widget.user == null
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  title: const Text(
                    "JobSnap",
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColors.whiteColor,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(100),
                    child: Column(
                      children: [
                        Container(
                            color: AppColors.whiteColor,
                            height: 50,
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            margin: const EdgeInsets.only(
                                bottom: 0, left: 0, top: 0),
                            child: CustomTextField(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: AppColors.appTextColor2,
                              ),
                              textInputType: TextInputType.text,
                              onchanged: (value) {
                                searchJob(search.text);
                              },
                              maxlines: 1,
                              labeltext: "Search For Job",
                              hideText: false,
                              hintText:
                                  "Search by name,location,posted by or keyword",
                              validator: (value) {},
                              controller: search,
                            )),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(top: 0),
                          height: 50,
                          color: AppColors.whiteColor,
                          width: double.maxFinite,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${searched_list.length} ${searched_list.length == 1 ? "Job" : "Jobs"} Found.",
                                  style: const TextStyle(
                                    color: AppColors.appTextColor2,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  splashColor: AppColors.appMainColor1,
                                  onPressed: () {
                                    // BlocProvider(
                                    //   create: (context) => JobCubits(jobService: JobService()),
                                    //   child: JobsDataLogicScreen(widget.user),
                                    // );
                                    setState(() {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      search.text = "";
                                      searched_list = widget.jobs;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: AppColors.appPrimaryColor,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 400,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: BlocProvider(
                      create: (context) => NotificationsCubit(
                          notificationService: NotificationService()),
                      child: AdSliderLogic(),
                    ),
                  ),
                ),
            //     SliverToBoxAdapter(
            //       child: Container(
            //         height: 50,
            //         child: _bannerAd != null?Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: _bannerAd!.size.width.toDouble(),
            //     height: _bannerAd!.size.height.toDouble(),
            //     child: AdWidget(ad: _bannerAd!),
            //   ),
            // ):Container()

            //       ),
            //     ),
                searched_list.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: AppColors.whiteColor,
                          child: Card(
                            elevation: 3,
                            color: AppColors.whiteColor1,
                            child: Container(
                              height: 300,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white10),
                                  color: AppColors.whiteColor1,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Center(
                                child: Text(
                                  "No Jobs Posted\n\nPlease Check Later",
                                  style: TextStyle(
                                    color: AppColors.appTextColor1,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : JobsWidget(searched_list, widget.user),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: const BoxDecoration(
                        // border: Border(color: Colors.white10),
                        ),
                    height: 100,
                    width: double.maxFinite,
                    child: const Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 2,
                            color: AppColors.appPrimaryColor,
                          ),
                          Spacer(),
                          Text(
                            "Terms and Conditions Apply\n\n  \u00a9 2023 ",
                            style: TextStyle(color: AppColors.appTextColor1),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void searchJob(String query) {
    final input = query.toLowerCase();
    setState(() {
      searched_list = widget.jobs.where((element) {
        return (element.jobDescription.toString().toLowerCase()).contains(input) ||
            (element.jobName.toString().toLowerCase()).contains(input) ||
            (element.postedBy.firstName + element.postedBy.lastName)
                .contains(input);
      }).toList();
    });
  }
}
