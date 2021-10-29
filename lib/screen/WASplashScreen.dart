import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/screen/WAWalkThroughScreen.dart';
import 'package:kepegawaian/utils/WAColors.dart';

class WASplashScreen extends StatefulWidget {
  static String tag = '/WASplashScreen';

  @override
  WASplashScreenState createState() => WASplashScreenState();
}

class WASplashScreenState extends State<WASplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(WAPrimaryColor,
        statusBarIconBrightness: Brightness.light);
    await Future.delayed(Duration(seconds: 3));
    if (mounted) finish(context);
    var nik = GetStorage().read('nik');
    nik != null ? Get.offAllNamed('/dashboard') : Get.offAllNamed('/login');
    //WAWalkThroughScreen().launch(context);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: WAPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/walletApp/wa_app_logo.png',
              color: Colors.white,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ).center(),
          ],
        ),
      ),
    );
  }
}
