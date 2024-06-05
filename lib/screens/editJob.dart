import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/ads/bannerAd.dart';

import '../config/colors.dart';
import '../config/urls.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/customWidgets.dart';
import '../widgets/expandTextField.dart';
import '../widgets/googleads.dart';
import '../widgets/loadingScreen.dart';
import '../widgets/postRules.dart';
import '../widgets/snackbar.dart';
import 'homescreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditJob extends StatefulWidget {
  UserModel user;
  JobsModel job;

  EditJob({required this.user,required this.job});

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  ScrollController scrollController = ScrollController();
  var jobname = TextEditingController();
  var jobdescription = TextEditingController();
  var qualification = TextEditingController();
  var applicationMethod = TextEditingController();
  var imageFile;

  var qualificationWordCount = 0;
  var descriptionWordCount = 0;
  var applicationWordCount = 0;

  JobService jobService = JobService();
  // var jobname = TextEditingController();
  bool isLoading = false;
  // int wordCount=

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
  void initState() {
    jobname.text = widget.job.jobName;
    jobdescription.text=widget.job.jobDescription;
    qualification.text=widget.job.qualification;
    applicationMethod.text=widget.job.applicationMethod;



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GoogleAdBannner(),
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
        title: const Text("Edit Job "),
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
              const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: double.maxFinite,
              child: ListView(
                padding: const EdgeInsets.only(top: 2),
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
                  imageFile != null
                      ? Container(
                    // height:
                    //     MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: [
                        Container(
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 35,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              print(imageFile.path);
                              // final dio = Dio(BaseOptions(
                              //   baseUrl: "${BaseUrls().baseUrl}jobs/",
                              //   // headers: {'Authorization': 'Bearer'},
                              //
                              // ));
                              // final uploader = ChunkedUploader(dio);
                              // final response = await uploader.uploadUsingFilePath(
                              //   fileName: "poster",
                              //   filePath: imageFile.path!,
                              //   maxChunkSize: 500000,
                              //   path: '/file',
                              //   onUploadProgress: (progress) => print(progress),
                              // );

                              var res = await jobService.jobPoster(
                                  verified: true,
                                  isImage: true,
                                  poster: imageFile.path,
                                  postedBy: widget.user?.id
                                      .toString() as String);
                              print(res);

                              if (res == 200 || res == 201) {
                                setState(() {
                                  isLoading = false;
                                });
                                // Navigator.of(context).pop(true);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    Utils.displayToast(
                                        "Posted.",
                                        Colors.green));
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return HomeScreen(widget.user);
                                        }));
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Utils.displayToast(
                                    "Unable to Post the Job \nA network error occurred.",
                                    Colors.pink));
                              }
                            },
                            child: const Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                      : Card(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      // height: 400,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor1,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
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
                                if (value == null ||
                                    value.isEmpty) {
                                  return "please fill in the  field";
                                } else if (value.toString().length <
                                    10) {
                                  return "Please write least 10 characters";
                                } else if (value.toString().length >
                                    99) {
                                  return "Please use less than 100 characters";
                                }
                                return null;
                              },
                              hideText: false,
                              maxlines: 1,
                              textInputType:
                              TextInputType.emailAddress),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandinTextField(
                              scrollController: scrollController,
                              labeltext: "Job Description",
                              hintText: "Some description",
                              controller: jobdescription,
                              onchanged: (value) {
                                var count = value.split("");
                                descriptionWordCount = count.length;

                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "please fill in the  field";
                                } else if (value.toString().length <
                                    10) {
                                  return "Please write least 10 characters";
                                } else if (value.toString().length >
                                    1000) {
                                  int wordCount =
                                      value.split("").length;

                                  return "Use less than 1000 characters.You have used $wordCount";
                                }
                                return null;
                              },
                              hideText: false,
                              textInputType:
                              TextInputType.multiline),
                          Container(
                            width: double.maxFinite,
                            height: 20,
                            child: Text(
                              "$descriptionWordCount/1000",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: AppColors.appTextColor2),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandinTextField(
                              scrollController: scrollController,
                              labeltext: "Job Qualifications",
                              hintText: "Some description",
                              controller: qualification,
                              onchanged: (value) {
                                var count = value.split("");
                                qualificationWordCount =
                                    count.length;

                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "please fill in the  field";
                                } else if (value.toString().length <
                                    10) {
                                  return "Please write least 10 characters";
                                } else if (value.toString().length >
                                    1000) {
                                  int wordCount =
                                      value.split("").length;

                                  return "Use less than 1000 characters.You have used $wordCount";
                                }
                                return null;
                              },
                              hideText: false,
                              textInputType:
                              TextInputType.multiline),
                          Container(
                            width: double.maxFinite,
                            height: 20,
                            child: Text(
                              "$qualificationWordCount/1000",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: AppColors.appTextColor2),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandinTextField(
                              scrollController: scrollController,
                              labeltext: "Method of Application",
                              hintText: "Some description",
                              controller: applicationMethod,
                              onchanged: (value) {
                                var count = value.split("");
                                applicationWordCount = count.length;
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "please fill in the  field";
                                } else if (value.toString().length <
                                    10) {
                                  return "Please write least 10 characters";
                                } else if (value.toString().length >
                                    1000) {
                                  int wordCount =
                                      value.split("").length;

                                  return "Use less than 1000 characters.You have used $wordCount";
                                }
                                return null;
                              },
                              hideText: false,
                              textInputType:
                              TextInputType.multiline),
                          Container(
                            width: double.maxFinite,
                            height: 20,
                            child: Text(
                              "$applicationWordCount/1000",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: AppColors.appTextColor2),
                            ),
                          ),
                          const PostRules(),
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
                                  if (_formKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    var res =
                                    await jobService.updateJob(
                                      id: widget.job.id.toString(),
                                      qualification:
                                      qualification.text,
                                      applicationMethod:
                                      applicationMethod.text,
                                      postedBy: widget.user!.id
                                          .toString(),
                                      jobName: jobname.text,
                                      jobDescription:
                                      jobdescription.text,
                                      verified: true,
                                    );

                                    if (res["status_code"] == 200 || res["status_code"] == 201) {
                                      setState(() {
                                        isLoading = false;
                                        jobname.text = "";
                                        jobdescription.text = "";
                                        applicationMethod.text = "";

                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          Utils.displayToast(
                                              "Job Updated Successfully",
                                              Colors.green));
                                      Navigator.of(context)
                                          .pop(true);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return HomeScreen(
                                                    widget.user);
                                              }));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          Utils.displayToast(
                                              "Unable to Post the Job \nA network error occurred.",
                                              Colors.pink));
                                    }
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
