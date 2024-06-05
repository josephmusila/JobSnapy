import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/jobsModel.dart';
import '../../services/jobServices.dart';
import 'jobStates.dart';

class JobCubits extends Cubit<JobState>{
  JobService jobService;

  JobCubits({required this.jobService}):super(JobsInitialState());

  List<JobsModel> jobs=[];
  List<JobsModel> filteredJobs=[];

  void getAllJobs() async {
    try{
      emit(JobsLoadingState());
      jobs = await jobService.getAllJobs();

      //only post verified jobs

      jobs.forEach((element) {
         element.verified?filteredJobs.add(element):false;
      });
      print(filteredJobs.length);
      // if (jobs.isEmpty){
      //   e/mit(NoJobsS/tate());
      // }
      // else{
        emit(JobsLoadedState(data: filteredJobs));
      // }


    }catch(exception){
      print(exception);
      emit(JobsDataError(exception.toString()));
    }
  }

  void goBack(){
    emit(JobsLoadedState(data: filteredJobs));
  }

  void deleteJob(String id,String user) async{
    emit(JobPostLoadingState());
    await jobService.deleteJob(id: id,user: user);
    emit(JobsLoadedState(data: jobs));
  }

   // void postJob({required String jobName,required String jobDescription,required int id}) async{
   //  try{
   //    emit(JobPostLoadingState());
   //    var response = await jobService.postJob(jobName: jobName, jobDescription: jobDescription,posted_by: id);
   //    print(response);
   //    emit(JobPostedState());
   //
   //  }catch (e){
   //    emit(JobPostingErrorState(e.toString()));
   //  }
  // }




}