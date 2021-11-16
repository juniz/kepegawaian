import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/screen/WAWalkThroughScreen.dart';
import 'package:kepegawaian/utils/WAColors.dart';

class WASplashScreen extends StatefulWidget {
  static String tag = '/WASplashScreen';

  @override
  WASplashScreenState createState() => WASplashScreenState();
}

class WASplashScreenState extends State<WASplashScreen> {
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(WAPrimaryColor,
        statusBarIconBrightness: Brightness.light);
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
    await Future.delayed(const Duration(seconds: 3));
    var username = GetStorage().read('nik');
    var password = GetStorage().read('password');

    var param = {
      'username': username,
      'password': password,
    };
    ApiConnection()
        .postData(
            url:
                'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/kepegawaian/login',
            body: param)
        .then((res) {
      //if (mounted) finish(context);
      var stts = res.statusCode;
      stts == 200 ? Get.offAllNamed('/dashboard') : Get.offAllNamed('/login');
    });
    // WAWalkThroughScreen().launch(context);
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
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1500),
              child: Image.asset(
                'images/walletApp/logo_rsbnganjuk.png',
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ).center(),
            ),
          ],
        ),
      ),
    );
  }
}
