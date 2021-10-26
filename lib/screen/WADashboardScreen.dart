import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kepegawaian/controller/presensi_controller.dart';
import 'package:kepegawaian/screen/WAHomeScreen.dart';
import 'package:kepegawaian/screen/WAMyProfileScreen.dart';
import 'package:kepegawaian/screen/WAQrScannerScreen.dart';
import 'package:kepegawaian/screen/WAStatisticsScreen.dart';
import 'package:kepegawaian/screen/WAWalletScreen.dart';
import 'package:kepegawaian/utils/WAColors.dart';
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(6.0),
        child: FloatingActionButton(
          backgroundColor: WAPrimaryColor,
          child: Icon(Icons.qr_code_scanner_sharp, color: Colors.white),
          onPressed: () async {
            // WAQrScannerScreen().launch(context);
            c.getImage(ImageSource.camera);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
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
                icon: Icon(Icons.date_range), label: 'Statistics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet_giftcard), label: 'Wallet'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
