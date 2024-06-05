import 'package:flutter/material.dart';
import 'package:jobsnap/widgets/statsWidget.dart';

import '../models/appStatistics.dart';


class AppStatsCard extends StatelessWidget {
  AppStats appStats;

  AppStatsCard({required this.appStats});



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: double.maxFinite,
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatsWidget(
              title: "Downloads",
              icon: Icons.download,
              iconColor: Colors.blue,
              count: appStats.statistics.downloads,
            ),
            StatsWidget(
              title: "Users",
              icon: Icons.account_circle,
              iconColor: Colors.pink,
              count: appStats.userCount,
            ),
            StatsWidget(
              title: "Visits",
              icon: Icons.visibility,
              iconColor: Colors.deepOrange,
              count: appStats.statistics.appVisits,
            ),
          ],
        ),
      ),
    );
  }
}
