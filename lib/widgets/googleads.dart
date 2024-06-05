import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdBannner extends StatefulWidget {


  @override
  State<GoogleAdBannner> createState() => _GoogleAdBannnerState();
}

class _GoogleAdBannnerState extends State<GoogleAdBannner> {

  late BannerAd bannerAd;
  bool isLoaded = false;
  var adUnitId="ca-app-pub-3940256099942544/6300978111";
  var bannerUnitId="ca-app-pub-7075855553997936/1074607355";
  var bannerTestUnitId="ca-app-pub-3940256099942544/6300978111";

  initBannerAd(){
    bannerAd=BannerAd(
        size: AdSize.banner,
        adUnitId: bannerUnitId,
        listener:BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                isLoaded=true;
              });
            },
            onAdFailedToLoad: (ad,error){
              ad.dispose();
            }
        ) ,
        request: const AdRequest()
    );
    bannerAd.load();
  }

  @override
  void initState() {

    initBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded?SizedBox(
      height: bannerAd.size.height.toDouble(),
      width: bannerAd.size.width.toDouble(),
      child: AdWidget(
        ad: bannerAd,
      ),
    ):const SizedBox();
  }
}

