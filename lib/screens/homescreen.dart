import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jobsnap/models/versionModel.dart';
import 'package:jobsnap/services/versionService.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import '../ads/bannerAd.dart';
import '../config/colors.dart';
import '../cubits/jobs/jobCubits.dart';
import '../logic/jobsLogic.dart';
import '../models/userModel.dart';
import '../services/jobServices.dart';
import '../widgets/googleads.dart';
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


  VersionService versionService = VersionService();
  late VersionModel versionModel;
  bool showUpdateCard = false;


  late BannerAd bannerAd;
  bool isLoaded = false;
  var adUnitId="ca-app-pub-3940256099942544/6300978111";
  var bannerUnitId="ca-app-pub-7075855553997936/1074607355";
  var bannerTestUnitId="ca-app-pub-3940256099942544/6300978111";

  initBannerAd(){
    bannerAd=BannerAd(
        size: AdSize.banner,
        adUnitId: bannerTestUnitId,
        listener:BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                isLoaded=true;
                print("isloaded");
              });
            },
            onAdFailedToLoad: (ad,error){
              ad.dispose();
              print("errorerrorerror");
              print("errorerrorerror");
              print("errorerrorerror");
            }
        ) ,
        request: const AdRequest()
    );
    bannerAd.load();
  }


  @override
  void initState() {
    // initBannerAd();
    FocusManager.instance.primaryFocus?.unfocus();

    // _initPackageInfo();
    // Future.delayed(const Duration(seconds: 5), () {
    //   checkUpdate();
    // });
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

  Future<void> checkUpdate() async {
    versionModel = await versionService.getUpdates();


    if (versionModel.version != _packageInfo.version) {
      setState(() {
        showUpdateCard = false;
      });
    } else {
     return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(

        backgroundColor: AppColors.whiteColor,
        bottomNavigationBar: GoogleAdBannner(),
        body: Container(
          color: Colors.white10,
          height: double.maxFinite,
          width: double.maxFinite,

          // child: BannerAdWidget(),
          //   child: Text(_packageInfo.buildNumber,style: TextStyle(color: Colors.black),),
          // ),
          child: Stack(
            children: [
              // JobList(user),
              // NewHomePage(),
              BlocProvider(
                create: (context) => JobCubits(jobService: JobService()),
                child: JobsDataLogicScreen(widget.user),
              ),
              showUpdateCard
                  ? Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.white24,
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(8),
                          // height: 300,
                          decoration: const BoxDecoration(
                            color: AppColors.appMainColor2,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Wrap(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Update Available",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                  Text("V${versionModel.version}",style: const TextStyle(
                                    color: Colors.white
                                  ),)
                                ],
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Details",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SelectableLinkify(text: versionModel.details, style: const TextStyle(color: Colors.white)),

                              // Text(
                              //   versionModel.details,
                              //   style: const TextStyle(color: Colors.white),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    // style: ,
                                    onPressed: () async {
                                      var url = Uri.parse(
                                          "https://jobsnap.vivatechy.com/api#downloads");

                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,mode: LaunchMode.externalApplication);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          Utils.displayToast(
                                              "Unable to open download page",
                                              AppColors.appPrimaryColor),
                                        );
                                      }
                                    },
                                    child: const Text("Update"),
                                  ),
                                  versionModel.isForcedUpdate
                                      ? Container()
                                      : TextButton(
                                          onPressed: () {
                                            setState(() {
                                              setState(() {
                                                showUpdateCard = false;
                                              });
                                            });
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
