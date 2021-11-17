import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdm_handal/controller/presensi_controller.dart';
import 'package:sdm_handal/screen/WAHomeScreen.dart';
import 'package:sdm_handal/screen/WAMyProfileScreen.dart';
import 'package:sdm_handal/screen/WAQrScannerScreen.dart';
import 'package:sdm_handal/screen/WAStatisticsScreen.dart';
import 'package:sdm_handal/screen/WAWalletScreen.dart';
import 'package:sdm_handal/screen/jadwal_dokter.dart';
import 'package:sdm_handal/screen/statistik.dart';
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
                c.getJamJaga();
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
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Container(
                                    decoration:
                                        boxDecorationRoundedWithShadow(12),
                                    child: ListTile(
                                      title: Text(e.shift!,
                                          style: boldTextStyle(size: 18)),
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
