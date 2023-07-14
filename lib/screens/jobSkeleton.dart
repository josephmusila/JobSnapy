import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/config/colors.dart';
import 'package:jobsnap/widgets/navDrawer.dart';

import '../cubits/Notifications/notificationCubit.dart';
import '../logic/adsSliderLogic.dart';
import '../services/notificationService.dart';
import '../widgets/adsSlider.dart';
import '../widgets/quotesWidget.dart';

class JobLoadingSkeleton extends StatefulWidget {
  const JobLoadingSkeleton({Key? key}) : super(key: key);

  @override
  State<JobLoadingSkeleton> createState() => _JobLoadingSkeletonState();
}

class _JobLoadingSkeletonState extends State<JobLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationController.repeat(reverse: true);
    animationController.addListener(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.appMainColor1,
        foregroundColor: Colors.black,
        splashColor: Colors.deepOrange,
        hoverElevation: 5,
        elevation: 5,
        onPressed: () {},
        icon: const Icon(
          Icons.network_check,
          color: AppColors.appTextColor3,
        ),
        label: const Text(
          "Loading...",
          style: TextStyle(color: AppColors.appTextColor3),
        ),
      ),
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.appMainColor2,
        title: const Text(
          "JobSnap",
          style: TextStyle(color: AppColors.whiteColor1,fontSize: 25),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.whiteColor1,
        child: ListView(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    AppColors.appMainColor2,
                    // AppColors.appMainColor2.withOpacity(0.2),
                    AppColors.appMainColor2,
                    Color.fromARGB(173, 20, 20, 50),
                    Colors.white,
                    Colors.white
                  ])),
              child: BlocProvider(
                create: (context) => NotificationsCubit(
                    notificationService: NotificationService()),
                child: AdSliderLogic(),
              ),
            ),
            QuotesWidget(),
            Column(
              children: List.generate(
                10,
                (index) => TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    curve: Curves.ease,
                    duration: Duration(seconds: index * 10),
                    builder: (context, double opacity, child) {
                      return AnimatedOpacity(
                        opacity: animationController.value,
                        duration: Duration(milliseconds: (index + 2) * 100),
                        onEnd: () {
                          opacity = 0;
                        },
                        curve: Curves.easeInOutCubicEmphasized,
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 0.9),
                            color: AppColors.whiteColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: 120,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.appTextColor2.withOpacity(0.5),
                                  radius: 25,
                                  child:  Text("${index+1}")
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  // margin: const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 5),
                                        height: 20,
                                        width: double.maxFinite,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 5),
                                        height: 40,
                                        width: double.maxFinite,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 20,
                                            // margin: const EdgeInsets.only(bottom:3),
                                            decoration: const BoxDecoration(
                                                color: AppColors.whiteColor1,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
