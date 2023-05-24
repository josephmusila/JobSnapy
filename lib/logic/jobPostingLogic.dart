import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubits/jobs/jobCubits.dart';
import '../cubits/jobs/jobStates.dart';
import '../screens/newjob.dart';
import '../widgets/errorScreen.dart';
import '../widgets/loadingScreen.dart';

class JobPostLogicScreen extends StatelessWidget {
  const JobPostLogicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<JobCubits, JobState>(builder: (context,state){
        if(state is JobsInitialState){
          return AddJob();
        }if(state is JobPostLoadingState){
          return LoadingScreen(message: 'Posting...',);
        }if(state is JobPostingErrorState){
          return ErrorScreen(error: state.message);
        }else{
          return AddJob();
        }
      },),
    );
  }
}
