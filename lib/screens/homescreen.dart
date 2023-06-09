
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/models/versionModel.dart';
import 'package:jobsnap/services/versionService.dart';


import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../logic/jobsLogic.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/snackbar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  UserModel? user;
  HomeScreen([this.user]);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var search = TextEditingController();

  var items = ["hello", "world"];
  VersionService versionService = VersionService();
  late VersionModel versionModel;
   bool showUpdateCard=false;

  @override
  void initState() {
    // TODO: implement initState
    FocusManager.instance.primaryFocus?.unfocus();
    _initPackageInfo();

    Future.delayed(const Duration(seconds: 5),(){

      checkUpdate();
      print(_packageInfo.version);
      // print(versionModel.version);
    });
    super.initState();
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



  Future<void> checkUpdate() async{
    versionModel=await versionService.getUpdates();
    print(versionModel.version);

    if(versionModel.version != _packageInfo.version){
      setState(() {
        showUpdateCard=true;
      });
    }else{
      print("No update available");
    }
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
          child:  Stack(
            children: [
              // JobList(user),

              BlocProvider(
                create: (context) => JobCubits(jobService: JobService()),
                child: JobsDataLogicScreen(widget.user),
              ),
              showUpdateCard?Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.white24,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    padding: const EdgeInsets.all(8),
                    height: 300,
                    decoration: const BoxDecoration(
                      color: AppColors.appMainColor2,
                      borderRadius: BorderRadius.all(Radius.circular(5)),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Update Available"),
                            Text("V${versionModel.version}")
                          ],
                        ),
                        const Divider(color: Colors.white,),
                        const SizedBox(height: 20,),
                         const Text("Details",style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 20,),
                         Text(versionModel.details,style: const TextStyle(color: Colors.white),),
                        const SizedBox(height: 20,),
                        const Divider(color: Colors.white,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(onPressed: () async{
                                    var url = Uri.parse("https://jobsnap.vivatechy.com/api#downloads");

                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        Utils.displayToast("Unable to open download page",
                                            AppColors.appMainColor2),
                                      );
                                    }
                            }, child: const Text("Update"),),
                           versionModel.isForcedUpdate? Container():TextButton(onPressed: (){
                              setState(() {
                                  setState(() {
                                    showUpdateCard=false;
                                  });
                              });
                            }, child: const Text("Cancel"),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}
