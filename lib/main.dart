import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sdm_handal/screen/IzinScreen.dart';
import 'package:sdm_handal/screen/JadwalPegawai.dart';
import 'package:sdm_handal/screen/KesehatanScreen.dart';
import 'package:sdm_handal/screen/RapatScreen.dart';
import 'package:sdm_handal/screen/WADashboardPresensi.dart';
import 'package:sdm_handal/screen/WALoginScreen.dart';
import 'package:sdm_handal/screen/WASplashScreen.dart';
import 'package:sdm_handal/screen/barcode_jaga.dart';
import 'package:sdm_handal/screen/buku_akreditasi.dart';
import 'package:sdm_handal/screen/jadwal_dokter.dart';
import 'package:sdm_handal/screen/rengiat.dart';
import 'package:sdm_handal/screen/riwayat_cuti.dart';
import 'package:sdm_handal/screen/riwayat_gaji.dart';
import 'package:sdm_handal/screen/riwayat_izin.dart';
import 'package:sdm_handal/screen/riwayat_jabatan.dart';
import 'package:sdm_handal/screen/riwayat_pendidikan.dart';
import 'package:sdm_handal/screen/riwayat_penghargaan.dart';
import 'package:sdm_handal/screen/riwayat_seminar.dart';
import 'package:sdm_handal/screen/statistik.dart';

import 'screen/WADashboardScreen.dart';
import 'screen/WASendMoneyViaLoopScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // OneSignal.shared.setAppId("492594ed-9b88-474c-891b-c055704850f6");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   //print("Accepted permission: $accepted");
  // });
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await GetStorage.init();
  // await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SDM Handal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => GetStorage().read('nik') != null
              ? WADashboardScreen()
              : WALoginScreen(),
        ),
        GetPage(name: '/splash', page: () => WASplashScreen()),
        GetPage(name: '/login', page: () => WALoginScreen()),
        GetPage(name: '/dashboard', page: () => WADashboardScreen()),
        GetPage(name: '/izin', page: () => IzinScreen()),
        GetPage(name: '/cuti', page: () => WASendMoneyViaLoopScreen()),
        GetPage(name: '/riwayatcuti', page: () => const RiwayatCuti()),
        GetPage(name: '/riwayatizin', page: () => const RiwayatIzin()),
        GetPage(name: '/riwayatseminar', page: () => const RiwayatSeminar()),
        GetPage(name: '/riwayatgaji', page: () => const RiwayatGaji()),
        GetPage(name: '/riwayatjabatan', page: () => const RiwayatJabatan()),
        GetPage(
            name: '/riwayatpendidikan',
            page: () => const RiwayatPendidikanPage()),
        GetPage(
            name: '/riwayatpenghargaan',
            page: () => const RiwayatPenghargaan()),
        GetPage(name: '/statistik', page: () => const Statistik()),
        GetPage(name: '/jadwaldokter', page: () => const JadwalDokterPage()),
        GetPage(name: '/rengiat', page: () => const RengiatPage()),
        GetPage(name: '/kesehatan', page: () => const KesehatanScreen()),
        GetPage(name: '/rapat', page: () => const RapatScreen()),
        GetPage(name: '/jadwalpegawai', page: () => const JadwalPegawai()),
        GetPage(
            name: '/dahboardpresensi', page: () => const WADashboardPresensi()),
        GetPage(name: '/akreditasi', page: () => const BukuAkreditasi()),
        GetPage(name: '/barcode', page: () => const BarcodeJaga()),
      ],
      initialRoute: '/splash',
    );
  }
}

// Future<void> initServices() async {
//   /// Here is where you put get_storage, hive, shared_pref initialization.
//   /// or moor connection, or whatever that's async.
//   await Get.putAsync(() => DbService().init());
// }

// class DbService extends GetxService {
//   Future<DbService> init() async {
//     print('$runtimeType delays 2 sec');
//     await 2.delay();
//     print('$runtimeType ready!');
//     return this;
//   }
// }


