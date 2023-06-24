import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/screens/jobSkeleton.dart';

import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../models/userModel.dart';
import '../widgets/errorScreen.dart';
import '../widgets/jobsList.dart';
import '../cubits/jobs/jobStates.dart';
import '../widgets/loadingScreen.dart';

class JobsDataLogicScreen extends StatefulWidget {
  UserModel? user;
  JobsDataLogicScreen([this.user]);

  @override
  State<JobsDataLogicScreen> createState() => _JobsDataLogicScreenState();
}

class _JobsDataLogicScreenState extends State<JobsDataLogicScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<JobCubits>(context).getAllJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubits, JobState>(
      builder: (context, state) {
        if (state is JobsInitialState) {
          return JobLoadingSkeleton();
        }
        if (state is JobsLoadingState) {
          // return JobList([], widget.user);
          // return LoadingScreen(message: "Loading Jobs From Portal");
          return JobLoadingSkeleton();
        }
        if (state is JobsLoadedState) {
          return JobList(state.data, widget.user);
          // return JobLoadingSkeleton();
          // }
          // if (state is JobsDataError) {
          //   return ErrorScreen(error: state.message);
        }
        if (state is NoJobsState) {
          return ErrorScreen(error: "No Jobs Posted Yet");
        } else {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 200,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 150,
                    // width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Network is Unreachable",
                          style: TextStyle(color: Colors.pink, fontSize: 18),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<JobCubits>(context).getAllJobs();
                            }, child: const Text("Retry"))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
