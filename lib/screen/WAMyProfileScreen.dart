import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/controller/profile_controller.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/screen/WAEditProfileScreen.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';

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
            'Profile',
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
                Obx(() => waCommonCachedNetworkImage(
                      'https://webapps.rsbhayangkaranganjuk.com/webapps/penggajian/${c.dataBiodata.value.photo!}',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: 120,
                      width: 120,
                    ).cornerRadiusWithClipRRect(60)),
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
                    title: 'Riwayat Hidup',
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
                    title: 'Riwayat Jabatan',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatjabatan');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Penghargaan',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatpenghargaan');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Pendidikan',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatpendidikan');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Seminar',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatseminar');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Riwayat Gaji',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      Get.toNamed('/riwayatgaji');
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Keluar',
                    decoration: boxDecorationRoundedWithShadow(12),
                    trailing:
                        Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      CoolAlert.show(
                          context: context,
                          backgroundColor: WAPrimaryColor,
                          confirmBtnColor: WAPrimaryColor,
                          confirmBtnText: 'Ya',
                          cancelBtnText: 'Tidak',
                          type: CoolAlertType.confirm,
                          title: 'Keluar Aplikasi',
                          text: 'Apakah anda yakin ingin keluar aplikasi ?',
                          onConfirmBtnTap: () async {
                            await GetStorage().erase();
                            Get.offAllNamed('/login');
                          },
                          onCancelBtnTap: () {
                            Get.back();
                          });
                    }),
                16.height,
              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
