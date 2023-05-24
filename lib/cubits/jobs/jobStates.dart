import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/jobsModel.dart';

abstract class JobState extends Equatable {}

class JobsInitialState extends JobState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JobsLoadingState extends JobState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class JobsLoadedState extends JobState {
  final List<JobsModel> data;

  JobsLoadedState({required this.data});
  @override
  // TODO: implement props
  List<Object> get props => [data];
}
class NoJobsState extends JobState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JobsDataError extends JobState {
  String message;

  JobsDataError(this.message);

  @override
  List<Object> get props => [message];
}

//posting states

class JobPostInitialState extends JobState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JobPostLoadingState extends JobState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JobPostedState extends JobState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class JobPostingErrorState extends JobState{
  String message;

  JobPostingErrorState(this.message);

  @override
  List<Object> get props => [message];
}
