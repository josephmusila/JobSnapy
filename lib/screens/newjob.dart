import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/colors.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/customWidgets.dart';
import '../widgets/loadingScreen.dart';
import '../widgets/postRules.dart';
import '../widgets/snackbar.dart';
import 'homescreen.dart';

class AddJob extends StatefulWidget {
  UserModel? user;

  AddJob([this.user]);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  ScrollController scrollController = ScrollController();
  var jobname = TextEditingController();
  var jobdescription = TextEditingController();
  var applicationMethod = TextEditingController();
  JobService jobService = JobService();
  // var jobname = TextEditingController();
  bool isLoading = false;

  final List<Map<String, dynamic>> _items = List.generate(
      10,
      (index) => {
            'id': index,
            "title": 'Item $index',
            "description": "some description",
            'isExpanded': false
          });
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // backgroundColor: Colors.transparent,
        backgroundColor: AppColors.appMainColor2,
        // elevation: 0,
        title: const Text("Post  Job "),
      ),
      body: isLoading
          ? LoadingScreen(
              message: "Posting..",
            )
          : Container(
              color: AppColors.whiteColor,
              height: double.maxFinite,
              width: double.maxFinite,
              child: Form(
                key: _formKey,
                child: Card(
                  elevation: 5,
                  color: AppColors.whiteColor,
                  shadowColor: Color.fromARGB(255, 1, 95, 236),
                  child: Container(
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColors.whiteColor,
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    height: double.maxFinite,
                    child: ListView(
                      padding: const EdgeInsets.only(top: 10),
                      // direction: Axis.vertical,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppColors.appMainColor2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 70,
                          child: const Text(
                            "Delete a job you posted by \njust swiping it on your profile screen",
                            style: TextStyle(
                                color: AppColors.appTextColor3,
                                height: 1.5,
                                fontSize: 15),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            // height: 400,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: AppColors.whiteColor1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                    labeltext: "Job Name",
                                    hintText: "job name",
                                    controller: jobname,
                                    onchanged: (value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please fill in the  field";
                                      } else if (value.toString().length < 10) {
                                        return "Please write least 10 characters";
                                      } else if (value.toString().length > 99) {
                                        return "Please use less than 100 characters";
                                      }
                                      return null;
                                    },
                                    hideText: false,
                                    maxlines: 1,
                                    textInputType: TextInputType.emailAddress),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                    scrollController: scrollController,
                                    labeltext: "Job Description",
                                    hintText: "Some description",
                                    controller: jobdescription,
                                    onchanged: (value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please fill in the  field";
                                      } else if (value.toString().length < 10) {
                                        return "Please write least 10 characters";
                                      } else if (value.toString().length >
                                          499) {
                                        return "Please use less than 500 characters";
                                      }
                                      return null;
                                    },
                                    hideText: false,
                                    maxlines: 6,
                                    textInputType: TextInputType.multiline),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                    scrollController: scrollController,
                                    labeltext: "Method of Application",
                                    hintText: "Method of Application",
                                    controller: applicationMethod,
                                    onchanged: (value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please fill in the  field";
                                      } else if (value.toString().length < 10) {
                                        return "Please write least 10 characters";
                                      } else if (value.toString().length >
                                          499) {
                                        return "Please use less than 500 characters";
                                      }
                                      return null;
                                    },
                                    hideText: false,
                                    maxlines: 3,
                                    textInputType: TextInputType.multiline),
                                PostRules(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 35,
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.appPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              title: const Text(
                                                "Confirm Details",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              content: Container(
                                                child: Wrap(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: const Text(
                                                        "Name",
                                                        style: TextStyle(
                                                            // decoration: TextDecoration.underline,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .appMainColor1),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width*0.6,
                                                      child: Text(
                                                        jobname.text,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .appTextColor1),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Description",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          // decoration: TextDecoration.underline,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .appMainColor1),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *0.6,
                                                      child: Text(
                                                        jobdescription.text,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .appTextColor1),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Application Method",
                                                      style: TextStyle(
                                                          // decoration: TextDecoration.underline,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .appMainColor1),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width*0.6,
                                                      child: Text(
                                                        applicationMethod.text,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .appTextColor1),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Divider(
                                                      color: AppColors
                                                          .appTextColor1,
                                                      height: 2,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    Navigator.of(context)
                                                        .pop(true);
                                                    var res = await jobService
                                                        .postJob(
                                                      applicationMethod:
                                                          applicationMethod
                                                              .text,
                                                      postedBy: widget.user!.id
                                                          .toString(),
                                                      jobName: jobname.text,
                                                      jobDescription:
                                                          jobdescription.text,
                                                      verified:true
                                                    );
                                                    print(res);
                                                    if (res == 200 ||
                                                        res == 201) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(Utils
                                                              .displayToast(
                                                                  "Job Posted",
                                                                  Colors
                                                                      .green));
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return HomeScreen(
                                                            widget.user);
                                                      }));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(Utils
                                                              .displayToast(
                                                                  "Unable to Post the Job \nA network error occurred.",
                                                                  Colors.pink));
                                                    }
                                                    Navigator.of(context)
                                                        .pop(true);
                                                    setState(() {
                                                      jobname.text = "";
                                                      jobdescription.text = "";
                                                      applicationMethod.text =
                                                          "";
                                                      isLoading = false;
                                                    });
                                                  },
                                                  child: const Text(
                                                    "Post",
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
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text("Post")),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
  }
}
