import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/cubits/statistics/statisticsCubits.dart';
import 'package:jobsnap/services/appStatisticsService.dart';
import 'package:jobsnap/widgets/statsWidget.dart';

import '../config/colors.dart';
import '../logic/statisticsLogicState.dart';
import '../models/appStatistics.dart';
import '../models/userModel.dart';
import 'newjob.dart';

class AdminPanel extends StatefulWidget {
  UserModel? user;
  AdminPanel([this.user]);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  AppStatsService appStatsService=AppStatsService();
  late AppStats appStats;

  @override
  void initState() {
    // appStats=appStatsService.getAppStats() as AppStats;
    // print(appStats.statistics);
    // TODO: implement initState
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(8),
        color: AppColors.whiteColor,
        child: ListView(
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.appTextColor1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: Container(
                // height: 220,
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                child:BlocProvider(
                  create: (context) =>
                      StatisticsCubit(appStatsService: AppStatsService()),
                  child: AppStatsLogicState(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //  Jobs Management
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                // direction: Axis.vertical,
                children: [
                  Container(
                    // color: Colors.red,
                    height: 50,
                    width: double.maxFinite,
                    child: const Center(
                      child: Text(
                        "Jobs Management",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AddJob(widget.user);
                          },
                        ),
                      );
                    },
                    title: const Text("Add Job"),
                    trailing: const Icon(Icons.add),
                  )),
                  Card(
                      child: ListTile(
                    onTap: () {},
                    title: const Text("Edit Job"),
                    trailing: const Icon(Icons.edit),
                  )),
                  Card(
                      child: ListTile(
                    onTap: () {},
                    title: const Text("Delete Job"),
                    trailing: const Icon(Icons.delete),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
