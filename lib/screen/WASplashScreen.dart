import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:device_info_plus/device_info_plus.dart';

class WASplashScreen extends StatefulWidget {
  static String tag = '/WASplashScreen';

  @override
  WASplashScreenState createState() => WASplashScreenState();
}

class WASplashScreenState extends State<WASplashScreen> {
  bool _visible = false;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String uuid = '';
  String mesin = '';
  String model = '';
  Map<String, dynamic> deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    init();
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
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
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var android = await deviceInfo.androidInfo;
      setState(() {
        uuid = android.androidId!;
        mesin = android.brand!;
        model = android.model!;
      });
    }
    if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var ios = await deviceInfo.iosInfo;
      setState(() {
        uuid = ios.identifierForVendor!;
        mesin = ios.name!;
        model = ios.model!;
      });
    }
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    var username = GetStorage().read('nik');
    var password = GetStorage().read('password');

    var param = {
      'username': username,
      'password': password,
      'app_id': osUserID,
      'uuid': uuid,
      'mesin': mesin,
      'model': model,
    };
    ApiConnection()
        .postData(
            url:
                'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v2/kepegawaian/login',
            body: param)
        .then((res) async {
      //if (mounted) finish(context);
      var stts = res.statusCode;
      if (stts == 200) {
        // if (Platform.isAndroid) {
        //   deviceData =
        //       _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        //print(deviceData);
        // } else if (Platform.isIOS) {
        //   deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        // }
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
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
