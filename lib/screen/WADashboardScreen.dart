import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:sdm_handal/controller/presensi_controller.dart';
import 'package:sdm_handal/screen/WAHomeScreen.dart';
import 'package:sdm_handal/screen/WAMyProfileScreen.dart';
import 'package:sdm_handal/screen/WAStatisticsScreen.dart';
import 'package:sdm_handal/screen/WAWalletScreen.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';

class WADashboardScreen extends StatefulWidget {
  static String tag = '/WADashboardScreen';

  @override
  WADashboardScreenState createState() => WADashboardScreenState();
}

class WADashboardScreenState extends State<WADashboardScreen> {
  final c = Get.put(PresensiController());
  int _selectedIndex = 0;
  var _pages = <Widget>[
    WAHomeScreen(),
    WAStatisticScreen(),
    // Statistik(),
    // JadwalDokterPage(),
    WAWalletScreen(),
    WAMyProfileScreen(),
  ];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(6.0),
        child: Obx(() => FloatingActionButton(
              backgroundColor: c.buttonColor.value,
              child: Icon(Icons.photo_camera, color: Colors.white),
              onPressed: () async {
                // WAQrScannerScreen().launch(context);
                // Get.back();

                c.determinePosition().then((value) {
                  if (value.isMocked) {
                    Get.snackbar(
                      'Error',
                      'Kemungkinan Aplikasi Mendeteksi Penggunaan Lokasi Palsu',
                      icon: const Icon(Icons.add_alert_outlined,
                          color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      borderRadius: 20,
                      margin: const EdgeInsets.all(15),
                      duration: const Duration(seconds: 5),
                      isDismissible: true,
                      dismissDirection: DismissDirection.horizontal,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  } else {
                    c.lat.value = value.latitude;
                    c.lng.value = value.longitude;
                    double distanceInMeters = Geolocator.distanceBetween(
                        -7.600011986205038,
                        111.89475748487666,
                        value.latitude,
                        value.longitude);
                    log(distanceInMeters);
                    if (distanceInMeters > 300) {
                      Get.snackbar(
                        'Error',
                        'Jarak Anda dan Rumah Sakit sekarang ${distanceInMeters.round()} m. Presensi harus dilakukan dengan jarak kurang dari 300 m dari Rumah Sakit.',
                        icon: const Icon(Icons.add_alert_outlined,
                            color: Colors.white),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        borderRadius: 20,
                        margin: const EdgeInsets.all(15),
                        duration: const Duration(seconds: 5),
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    } else {
                      if (c.listJamJaga.value.isNotEmpty) {
                        Get.bottomSheet(
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16, bottom: 16),
                            width: Get.width,
                            height: Get.height / 2,
                            decoration: boxDecorationWithShadow(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: SingleChildScrollView(
                              child: Obx(
                                () => Column(
                                  children: c.listJamJaga.value
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 10,
                                              bottom: 10),
                                          child: Container(
                                            decoration:
                                                boxDecorationRoundedWithShadow(
                                                    12),
                                            child: ListTile(
                                              title: Text(e.shift!,
                                                  style:
                                                      boldTextStyle(size: 18)),
                                              subtitle: Text(
                                                  '${e.jamMasuk} - ${e.jamPulang}'),
                                              onTap: () {
                                                c.shift.value = e.shift!;
                                                c.getImage(ImageSource.camera);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          isDismissible: false,
                        );
                      }
                    }
                  }
                }).catchError((error) {
                  Get.snackbar(
                    'Error',
                    error.toString(),
                    icon: const Icon(Icons.add_alert_outlined,
                        color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    borderRadius: 20,
                    margin: const EdgeInsets.all(15),
                    duration: const Duration(seconds: 5),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                });

                // CoolAlert.show(
                //     context: context,
                //     backgroundColor: WAPrimaryColor,
                //     confirmBtnColor: WAPrimaryColor,
                //     type: CoolAlertType.info,
                //     title: 'Gunakan Lokasimu Sekarang',
                //     text:
                //         'SDM Handal mengumpulkan data lokasi untuk mengaktifkan fitur presensi pegawai',
                //     confirmBtnText: "Izinkan",
                //     cancelBtnText: "Batal",
                //     showCancelBtn: true,
                //     onConfirmBtnTap: () async {

                //     });

                //c.getImage(ImageSource.camera);
              },
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.5,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: WAPrimaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: 'Presensi'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.bar_chart), label: 'statistik'),
            // BottomNavigationBarItem(
            //     icon: Icon(AntDesign.contacts), label: 'jadwaldokter'),
            BottomNavigationBarItem(
                icon: Icon(AntDesign.infocirlce), label: 'Informasi'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
