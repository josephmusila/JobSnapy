


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/cubits/statistics/statisticsState.dart';

import '../../models/appStatistics.dart';
import '../../services/appStatisticsService.dart';




class StatisticsCubit extends Cubit<StatisticsState>{
  AppStatsService appStatsService;

  StatisticsCubit({required this.appStatsService}):super(StatisticsInitialState());



  late AppStats appStats;


  void getStatistics() async{
    emit(StatisticsLoadingState());
    try {
      appStats = await appStatsService.getAppStats();
      if (appStats == null){
        emit(NoStatisticsState());
      }else{
        emit(StatisticsLoadedState(appStats));
      }
    } on Exception catch (e) {
      emit(StatisticsLoadingErrorState(e.toString()));
    }
  }
}