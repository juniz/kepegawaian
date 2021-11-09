import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/helper.dart';

class ChartIzinController extends GetxController {
  var nik = "".obs;
  var leftBarColor = WAPrimaryColor;
  var rightBarColor = Colors.red;
  late var width = 7;

  late var rawBarGroups = <BarChartGroupData>[].obs;
  late var showingBarGroups = <BarChartGroupData>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await getJmlCuti();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getJmlCuti() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {
        'nik': nik.value,
      };

      var data = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahizin',
          body: param);

      var e = data.body;
      // print(e);
      // jmlCuti.value = data.body;
      showingBarGroups.value = [
        makeGroupData(0, e['jan'].toDouble(), 12),
        makeGroupData(1, e['feb'].toDouble(), 12),
        makeGroupData(2, e['mar'].toDouble(), 5),
        makeGroupData(3, e['apr'].toDouble(), 16),
        makeGroupData(4, e['mei'].toDouble(), 6),
        makeGroupData(5, e['jun'].toDouble(), 1.5),
        makeGroupData(6, e['jul'].toDouble(), 1.5),
        makeGroupData(7, e['agu'].toDouble(), 1.5),
        makeGroupData(8, e['sep'].toDouble(), 1.5),
        makeGroupData(9, e['okt'].toDouble(), 1.5),
        makeGroupData(10, e['nov'].toDouble(), 1.5),
        makeGroupData(11, e['des'].toDouble(), 1.5),
      ];
      DialogHelper.hideLoading();
    } on Exception catch (e) {
      // TODO
      DialogHelper.hideLoading();
    }
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(
    barsSpace: 7,
    x: x,
    barRods: [
      BarChartRodData(y: y1, colors: [WAPrimaryColor], width: 7),
    ],
  );
}
