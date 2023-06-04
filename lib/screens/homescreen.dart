import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../logic/jobsLogic.dart';
import '../models/jobsModel.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/navDrawer.dart';
import 'jobDetail.dart';
import 'newjob.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  UserModel? user;
  HomeScreen([this.user]);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var search = TextEditingController();

  var items = ["hello", "world"];

  @override
  void initState() {
    // TODO: implement initState
    FocusManager.instance.primaryFocus?.unfocus();
    _initPackageInfo();
    Future.delayed(const Duration(seconds: 5),(){
      printInfo();
    });
    super.initState();
  }

  double getSizes(BuildContext context){

    return MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
    
  }
  
  Future<void> printInfo() async{
    print(_packageInfo.appName);
    print(_packageInfo.version);
    print(_packageInfo.buildNumber);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>true,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
          color: Colors.white10,
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              // JobList(user),
              BlocProvider(
                create: (context) => JobCubits(jobService: JobService()),
                child: JobsDataLogicScreen(widget.user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
