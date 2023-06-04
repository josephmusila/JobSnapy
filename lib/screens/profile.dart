import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/screens/updateProfile.dart';

import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../logic/jobsLogic.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/postedJobDetail.dart';
import 'jobDetail.dart';

class ProfileScreen extends StatefulWidget {
  UserModel user;
  List<JobsModel>? jobs;
  ProfileScreen(this.user, [this.jobs]);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<JobsModel> userJobs = [];
  List<JobsModel> appliedJobs = [];
  var applicantsVisible = false;
  JobService jobService = JobService();
  // List<PostedBy> applicants=[];
  @override
  void initState() {
    selectUserJobs();
    selectAppliedJobs();
    super.initState();
  }

  void selectUserJobs() {
    userJobs = widget.jobs!.where((element) {
      return element.postedBy.id == widget.user.id;
    }).toList();
  }

  void selectApplicants() {
    // applicants = userJobs
  }

  void selectAppliedJobs() {
    for (var i = 0; i < widget.jobs!.length; i++) {
      for (var j = 0; j < widget.jobs![i].applicants.length; j++) {
        if (widget.jobs![i].applicants[j].id == widget.user.id) {
          appliedJobs.add(widget.jobs![i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appMainColor2,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => JobCubits(jobService: JobService()),
                child: JobsDataLogicScreen(widget.user),
              );
            }));
          },
        ),
        backgroundColor: AppColors.appMainColor2,
        // elevation: 0,
        title: Text("${widget.user.firstName} ${widget.user.lastName}"),
      ),
      // drawer: NavigationDrawer(),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
        color: AppColors.whiteColor,
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 70,
                          left: 20,
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 70,
                            color: AppColors.appPrimaryColor,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appMainColor1),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return UpdateProfilePage(user: widget.user);
                              }));
                            },
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                color: AppColors.appTextColor3,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: Container(
                            color: AppColors.whiteColor1,
                            padding: const EdgeInsets.all(5),
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  widget.user.phone,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.appTextColor1),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.user.email,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.appTextColor1),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.transparent,
                          child: Container(
                            height: 30,
                            width: 150,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            margin: const EdgeInsets.only(left: 10, right: 5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // color: AppColors.whiteColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Statistics",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appTextColor1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.white, width: 1),
                            color: AppColors.appMainColor1.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(10),
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.upload,
                                color: AppColors.appTextColor2,
                                size: 30,
                              ),
                              Text(
                                "Posted: ${userJobs.length}",
                                style: const TextStyle(
                                  color: AppColors.appTextColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.white, width: 1),
                            color: AppColors.appMainColor1.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(10),
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.work_history_outlined,
                                color: AppColors.appTextColor2,
                                size: 30,
                              ),
                              Text(
                                "Applied: ${appliedJobs.length}",
                                style: const TextStyle(
                                  color: AppColors.appTextColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              color: AppColors.appPrimaryColor,
              height: 4,
            ),
            Container(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Posted Jobs",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "**Swipe to delete",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.appPrimaryColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            //check if user has posted any Jobs
            userJobs.isEmpty
                ? Card(
                    child: Container(
                      margin: const EdgeInsets.only(top: 0, right: 0),
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: const Center(
                        child: Text(
                          "You haven't Posted any Job",
                          style: TextStyle(
                              color: AppColors.appTextColor1, fontSize: 18),
                        ),
                      ),
                    ),
                  )
                : PostedJobDetail(userJobs: userJobs, user: widget.user),

            const Divider(
              color: Colors.white,
            ),
            const Text(
              "Applied Jobs",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            appliedJobs.isEmpty
                ? Card(
                    child: Container(
                      // margin: const EdgeInsets.only(top: 10, right: 5),
                      height: 100,
                      width: double.maxFinite,
                      decoration:
                          const BoxDecoration(color: AppColors.whiteColor),
                      child: const Center(
                        child: Text(
                          "You haven't Applied for any Job",
                          style: TextStyle(
                              color: AppColors.appTextColor1, fontSize: 18),
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: List.generate(
                      appliedJobs.length,
                      (index) => appliedJobs[index].isImage?Container(
                        height: 200,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.network(
                                  appliedJobs[index].poster.toString()),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                TextButton(
                                  child: const Text(
                                    "See Details",
                                    style: TextStyle(
                                        color: AppColors.appPrimaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return JobDetail(appliedJobs[index],
                                              widget.user);
                                        }));
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ):Card(
                        elevation: 5,
                        color: AppColors.whiteColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return JobDetail(appliedJobs[index], widget.user);
                            }));
                          },
                          leading: Text(
                            "${index + 1}",
                            style:
                                const TextStyle(color: AppColors.appTextColor2),
                          ),
                          title: Text(
                            appliedJobs[index].jobName,
                            style:
                                const TextStyle(color: AppColors.appTextColor1),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.appPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return JobDetail(
                                        appliedJobs[index], widget.user);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
