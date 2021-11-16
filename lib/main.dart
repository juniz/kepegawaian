import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/screen/IzinScreen.dart';
import 'package:kepegawaian/screen/WALoginScreen.dart';
import 'package:kepegawaian/screen/WASplashScreen.dart';
import 'package:kepegawaian/screen/jadwal_dokter.dart';
import 'package:kepegawaian/screen/rengiat.dart';
import 'package:kepegawaian/screen/riwayat_cuti.dart';
import 'package:kepegawaian/screen/riwayat_gaji.dart';
import 'package:kepegawaian/screen/riwayat_izin.dart';
import 'package:kepegawaian/screen/riwayat_jabatan.dart';
import 'package:kepegawaian/screen/riwayat_pendidikan.dart';
import 'package:kepegawaian/screen/riwayat_penghargaan.dart';
import 'package:kepegawaian/screen/riwayat_seminar.dart';
import 'package:kepegawaian/screen/statistik.dart';

import 'screen/WADashboardScreen.dart';
import 'screen/WASendMoneyViaLoopScreen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KEPEGAWAIAN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
            name: '/',
            page: () => GetStorage().read('nik') != null
                ? WADashboardScreen()
                : WALoginScreen()),
        GetPage(name: '/splash', page: () => WASplashScreen()),
        GetPage(name: '/login', page: () => WALoginScreen()),
        GetPage(name: '/dashboard', page: () => WADashboardScreen()),
        GetPage(name: '/izin', page: () => IzinScreen()),
        GetPage(name: '/cuti', page: () => WASendMoneyViaLoopScreen()),
        GetPage(name: '/riwayatcuti', page: () => RiwayatCuti()),
        GetPage(name: '/riwayatizin', page: () => RiwayatIzin()),
        GetPage(name: '/riwayatseminar', page: () => RiwayatSeminar()),
        GetPage(name: '/riwayatgaji', page: () => RiwayatGaji()),
        GetPage(name: '/riwayatjabatan', page: () => RiwayatJabatan()),
        GetPage(
            name: '/riwayatpendidikan', page: () => RiwayatPendidikanPage()),
        GetPage(name: '/riwayatpenghargaan', page: () => RiwayatPenghargaan()),
        GetPage(name: '/statistik', page: () => Statistik()),
        GetPage(name: '/jadwaldokter', page: () => JadwalDokterPage()),
        GetPage(name: '/rengiat', page: () => RengiatPage()),
      ],
      initialRoute: '/splash',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
