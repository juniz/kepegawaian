import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jml_cuti_model.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/helper.dart';

class ChartController extends GetxController {
  var nik = "".obs;
  var context = Get.context;
  var leftBarColor = WAPrimaryColor;
  var rightBarColor = Colors.red;
  late var width = 7;
  var chart = "".obs;
  var url = "".obs;

  late var rawBarGroups = <BarChartGroupData>[].obs;
  late var showingBarGroups = <BarChartGroupData>[].obs;
  late var jmlCuti = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    chart.value = "Cuti";
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
        // () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {
        'nik': nik.value,
      };
      if (chart.value == 'Cuti') {
        url.value =
            'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahcuti';
      } else {
        url.value =
            'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahizin';
      }

      var data = await ApiConnection().postData(url: url.value, body: param);
      // var izin = await ApiConnection().postData(
      //     url:
      //         'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahizin',
      //     body: param);

      var e = data.body;
      //var a = izin.body;
      // print(e);
      // jmlCuti.value = data.body;
      showingBarGroups.value = [
        makeGroupData(0, e['jan'].toDouble(), chart.value),
        makeGroupData(1, e['feb'].toDouble(), chart.value),
        makeGroupData(2, e['mar'].toDouble(), chart.value),
        makeGroupData(3, e['apr'].toDouble(), chart.value),
        makeGroupData(4, e['mei'].toDouble(), chart.value),
        makeGroupData(5, e['jun'].toDouble(), chart.value),
        makeGroupData(6, e['jul'].toDouble(), chart.value),
        makeGroupData(7, e['agu'].toDouble(), chart.value),
        makeGroupData(8, e['sep'].toDouble(), chart.value),
        makeGroupData(9, e['okt'].toDouble(), chart.value),
        makeGroupData(10, e['nov'].toDouble(), chart.value),
        makeGroupData(11, e['des'].toDouble(), chart.value),
      ];
      DialogHelper.hideLoading();
    } on Exception catch (e) {
      // TODO
      DialogHelper.hideLoading();
    }
  }
}

BarChartGroupData makeGroupData(int x, double y1, String y2) {
  return BarChartGroupData(
    barsSpace: 7,
    x: x,
    barRods: [
      BarChartRodData(
          y: y1,
          colors: [y2 == 'Cuti' ? WAPrimaryColor : Color(0xFFFF7426)],
          width: 7),
      //BarChartRodData(y: y2, colors: [Color(0xFFFF7426)], width: 7),
    ],
  );
}
