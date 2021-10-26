import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kepegawaian/controller/cuti_controller.dart';
import 'package:kepegawaian/controller/profile_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/screen/WAEditProfileScreen.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';

class WAMyProfileScreen extends StatefulWidget {
  static String tag = '/WAMyProfileScreen';

  @override
  WAMyProfileScreenState createState() => WAMyProfileScreenState();
}

class WAMyProfileScreenState extends State<WAMyProfileScreen> {
  final c = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void dispose() {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'My Profile',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/walletApp/wa_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                waCommonCachedNetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB8vuaWT6wGaoDz6T0UEilQ8wwcFO-hvserEgijbpPulSLBBpgbkxZBjwhUsU3ULuPazM&usqp=CAU',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ).cornerRadiusWithClipRRect(60),
                16.height,
                Obx(
                  () => Text(c.dataBiodata.value.nama!, style: boldTextStyle()),
                ),
                Obx(
                  () => Text(c.dataBiodata.value.nik!,
                      style: secondaryTextStyle()),
                ),
                16.height,
                SettingItemWidget(
                    title: 'Edit Profile',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      WAEditProfileScreen(isEditProfile: true).launch(context);
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Cuti',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatcuti');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Izin',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatizin');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Settings',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      //
                    }),
              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
