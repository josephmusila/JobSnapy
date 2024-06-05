import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/cubits/statistics/statisticsCubits.dart';
import 'package:jobsnap/cubits/statistics/statisticsState.dart';
import 'package:jobsnap/widgets/loadingScreen.dart';

import '../widgets/allStatsCard.dart';

class AppStatsLogicState extends StatefulWidget {
  const AppStatsLogicState({super.key});

  @override
  State<AppStatsLogicState> createState() => _AppStatsLogicStateState();
}

class _AppStatsLogicStateState extends State<AppStatsLogicState> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<StatisticsCubit>(context).getStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
      if (state is StatisticsLoadingState) {
        return Container();
      } else if (state is StatisticsLoadingState) {
        return Container(
          height: 200,
          width: double.maxFinite,
          padding: const EdgeInsets.all(10),
          child: LoadingScreen(message: 'Loading',),
        );
      } else if (state is StatisticsLoadedState) {
        return AppStatsCard(appStats: state.appStats,);
      } else {
        return Container();
      }
    });
  }
}
