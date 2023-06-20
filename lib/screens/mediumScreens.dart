import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/screens/profile.dart';
import 'package:jobsnap/widgets/errorScreen.dart';
import 'package:jobsnap/widgets/jobItem.dart';
import 'package:jobsnap/widgets/jobWidget.dart';
import 'package:jobsnap/widgets/navDrawer.dart';

import '../config/colors.dart';
import '../cubits/Notifications/notificationCubit.dart';
import '../logic/adsSliderLogic.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../services/notificationService.dart';
import '../widgets/adsSlider.dart';
import '../widgets/customWidgets.dart';
import 'customerCare.dart';
import 'jobDetail.dart';
import 'loginPage.dart';

enum SelectedScreen {
  Home,
  Abuse,
  Bug,
  CustomerCare,
  About,
  NavDrawer,
  Login,
  Register,
  JobDetail
}

class MediumScreen extends StatefulWidget {
  List<JobsModel> jobs;
  UserModel? user;

  MediumScreen(this.jobs, [this.user]);
  @override
  State<MediumScreen> createState() => _MediumScreenState();
}

class _MediumScreenState extends State<MediumScreen> {
  List<JobsModel> searched_list = [];

  SelectedScreen selectedScreen = SelectedScreen.NavDrawer;
  var search = TextEditingController();
  late JobsModel currentJob;
  Color selectedColor = AppColors.whiteColor1;
  int selectedIndex = 0;

  void initState() {
    searched_list = widget.jobs;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.user == null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProfileScreen(
                              widget.user as UserModel, widget.jobs);
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
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: widget.user == null ? Colors.red : Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        backgroundColor: AppColors.appMainColor2,
        title: const Text(
          "JobSnap",
          style: TextStyle(color: AppColors.appPrimaryColor),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.maxFinite,
                color: AppColors.whiteColor,
                child: selectedScreen == SelectedScreen.JobDetail
                    ? JobDetail(currentJob)
                    : Column(
                        children: [
                          Container(
                            color: AppColors.appMainColor2,
                            height: 300,
                            child: BlocProvider(
                              create: (context) => NotificationsCubit(notificationService: NotificationService()),
                              child: AdSliderLogic(),
                            ),
                          ),
                          // Container(
                          //   height: 500,
                          //   child: CustomerCare(),
                          // ),
                          Spacer(),

                          Container(
                            height: 200,
                            color: AppColors.whiteColor,
                            child: Center(
                              child: Card(
                                child: Container(
                                  height: 100,
                                  // width: 300,
                                  color: AppColors.whiteColor1,
                                  child: const Center(
                                      child: Text(
                                    "No New Notifications",
                                    style: TextStyle(
                                        color: AppColors.appTextColor1),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: AppColors.whiteColor,
                height: double.maxFinite,
                child: ListView(
                  children: [
                    Container(
                      height: 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        searched_list = searched_list;
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: searched_list.isEmpty
                          ? ErrorScreen(
                              error: "No Jobs Posted Yet\n\nPlease Check Later")
                          : ListView(
                              children: List.generate(
                                searched_list.length,
                                (index) => index % 10 == 0
                                    ? Container(
                                        width: double.maxFinite,
                                        height: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: AppColors.whiteColor1,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Good Luck With Your Job Search ${widget.user == null ? "" : "@${widget.user?.firstName}"}",
                                            style: const TextStyle(
                                              color: AppColors.appPrimaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : JobItem(searched_list, index, () {
                                        setState(() {
                                          selectedScreen =
                                              SelectedScreen.JobDetail;
                                          currentJob = searched_list[index];
                                          selectedColor =
                                              AppColors.appSelectedItem;
                                          selectedIndex = index;
                                          print(selectedScreen);
                                        });
                                      },
                                        selectedIndex == index &&
                                                selectedIndex != null
                                            ? selectedColor
                                            : AppColors.whiteColor1),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
