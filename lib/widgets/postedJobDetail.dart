import 'package:flutter/material.dart';
import 'package:jobsnap/services/jobServices.dart';

import '../config/colors.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../screens/jobDetail.dart';
import 'applicants.dart';

class ShowApplicants {
  int index;
  bool isVisible;

  ShowApplicants({required this.index, required this.isVisible});
}

class PostedJobDetail extends StatefulWidget {
  List<JobsModel> userJobs;
  UserModel user;

  PostedJobDetail({required this.userJobs, required this.user});

  @override
  State<PostedJobDetail> createState() => _PostedJobDetailState();
}

class _PostedJobDetailState extends State<PostedJobDetail> {
  ShowApplicants showApplicants = ShowApplicants(index: 0, isVisible: false);
  JobService jobService = JobService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.userJobs.length,
        (index) => Column(
          children: [
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  jobService.deleteJob(
                      user: widget.user?.id.toString() as String,
                      id: widget.userJobs[index].id.toString());
                  jobService.getAllJobs();
                  widget.userJobs.removeAt(index);
                });
              },
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.whiteColor,
                    title: const Text(
                      "Delete Job",
                      style: TextStyle(color: Colors.red),
                    ),
                    content: const Text(
                      "Do you wish to delete this Job?",
                      style: TextStyle(
                        color: AppColors.appTextColor2,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                );
              },
              background: Container(
                color: AppColors.appMainColor1,
                child: Icon(Icons.delete),
              ),
              child: Card(
                elevation: 2,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black12),
                  ),
                  padding: const EdgeInsets.all(5),
                  height: 100,
                  width: double.maxFinite,
                  child: widget.userJobs[index].isImage
                      ? Container(
                          height: 200,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Image.network(
                                    widget.userJobs[index].poster.toString()),
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
                                        return JobDetail(widget.userJobs[index],
                                            widget.user);
                                      }));
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Positioned(
                                child: Text(
                              "${index + 1}. ${widget.userJobs[index].jobName}",
                              style: const TextStyle(
                                  color: AppColors.appTextColor1, fontSize: 16),
                            )),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: TextButton(
                                  child: const Text(
                                    "See Details",
                                    style: TextStyle(
                                        color: AppColors.appPrimaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return JobDetail(
                                          widget.userJobs[index], widget.user);
                                    }));
                                  },
                                )),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showApplicants.isVisible =
                                        !showApplicants.isVisible;
                                    showApplicants.index = index;
                                  });
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColors.appMainColor1,
                                    ),
                                    child: Text(
                                      "${widget.userJobs[index].applicants.length}  ${widget.userJobs[index].applicants.length == 1 ? "applicant" : "applicants"}",
                                      style: const TextStyle(
                                          color: AppColors.appTextColor3,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
            showApplicants.index == index && showApplicants.isVisible == true
                ? Card(
                    elevation: 5,
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26),
                          left: BorderSide(width: 1, color: Colors.black26),
                          right: BorderSide(width: 1, color: Colors.black26),
                        ),
                      ),
                      child: ApplicantsWidget(
                        applicants:
                            widget.userJobs[index].applicants as List<PostedBy>,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
