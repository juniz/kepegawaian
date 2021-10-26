import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/jml_cuti_model.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/helper.dart';

class ChartController extends GetxController {
  var nik = "".obs;
  var context = Get.context;
  var leftBarColor = WAPrimaryColor;
  var rightBarColor = Colors.red;
  late var width = 7;

  late var rawBarGroups = <BarChartGroupData>[].obs;
  late var showingBarGroups = <BarChartGroupData>[].obs;
  late var jmlCuti = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    print(nik.value);
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
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahcuti',
          body: param);
      var izin = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahizin',
          body: param);

      var e = data.body;
      var a = izin.body;
      print(e);
      // jmlCuti.value = data.body;
      showingBarGroups.value = [
        makeGroupData(0, e['jan'].toDouble(), a['jan'].toDouble()),
        makeGroupData(1, e['feb'].toDouble(), a['feb'].toDouble()),
        makeGroupData(2, e['mar'].toDouble(), a['mar'].toDouble()),
        makeGroupData(3, e['apr'].toDouble(), a['apr'].toDouble()),
        makeGroupData(4, e['mei'].toDouble(), a['mei'].toDouble()),
        makeGroupData(5, e['jun'].toDouble(), a['jun'].toDouble()),
        makeGroupData(6, e['jul'].toDouble(), a['jul'].toDouble()),
        makeGroupData(7, e['agu'].toDouble(), a['agu'].toDouble()),
        makeGroupData(8, e['sep'].toDouble(), a['sep'].toDouble()),
        makeGroupData(9, e['okt'].toDouble(), a['okt'].toDouble()),
        makeGroupData(10, e['nov'].toDouble(), a['nov'].toDouble()),
        makeGroupData(11, e['des'].toDouble(), a['des'].toDouble()),
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
      BarChartRodData(y: y2, colors: [Colors.red], width: 7),
    ],
  );
}
