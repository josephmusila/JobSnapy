

import 'package:equatable/equatable.dart';

import '../../models/appStatistics.dart';



abstract class StatisticsState extends Equatable{

}

class StatisticsInitialState extends StatisticsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class StatisticsLoadingState extends StatisticsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class StatisticsLoadedState extends StatisticsState{
  AppStats appStats;

  StatisticsLoadedState(this.appStats);
  @override
  // TODO: implement props
  List<Object?> get props => [appStats];

}

class NoStatisticsState extends StatisticsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class StatisticsLoadingErrorState extends StatisticsState{

  String message;
  StatisticsLoadingErrorState(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}