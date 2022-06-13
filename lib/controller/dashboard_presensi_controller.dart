import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/absensi_pegawai_model.dart';
import 'rekap_presensi_controller.dart';

class DashboardPresensiController extends GetxController {
  final provider = Get.put(ApiConnection());
  final listAbsensiUnit = <AbsensiUnit>[].obs;
  final listAbsensiPegawai = <AbsensiPegawai>[].obs;
  var listBarAbsensiUnit = <BarChartGroupData>[].obs;
  late TooltipBehavior tooltipBehavior;
  late ZoomPanBehavior zoomPanBehavior;
  var months = <Bulan>[].obs;
  var years = <String>[].obs;
  var monthSelected = DateTime.now().month.toString().obs;
  var yearSelected = DateTime.now().year.toString().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    months.value = [
      Bulan('January', '1'),
      Bulan('Februari', '2'),
      Bulan('Maret', '3'),
      Bulan('April', '4'),
      Bulan('Mei', '5'),
      Bulan('Juni', '6'),
      Bulan('Juli', '7'),
      Bulan('Agustus', '8'),
      Bulan('September', '9'),
      Bulan('Oktober', '10'),
      Bulan('November', '11'),
      Bulan('Desember', '12')
    ];
    years.value = [
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
    ];
    tooltipBehavior = TooltipBehavior(enable: true);
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      // enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      selectionRectBorderWidth: 1,
      selectionRectColor: Colors.grey,
    );
    getAbsensiUnit();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getAbsensiUnit() async {
    var data = {
      'tanggal': '${yearSelected.value}-${monthSelected.value.padLeft(2, '0')}',
    };
    var i = 0;
    Future.delayed(
      Duration.zero,
      () => provider.absensiUnit(data).then((value) {
        listAbsensiUnit.value = absensiUnitFromJson(value.bodyString!);
        listAbsensiUnit.value.forEach(
          (element) {
            listBarAbsensiUnit.value.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    y: element.terlambat2!.toDouble(),
                  ),
                ],
              ),
            );
            i++;
          },
        );
      }),
    );
  }

  getAbsensiPegawai(String? departemen) {
    var data = {
      'tanggal': '${yearSelected.value}-${monthSelected.value.padLeft(2, '0')}',
      'departemen': departemen,
    };
    Future.delayed(
      Duration.zero,
      () => provider.absensiPegawai(data).then((value) {
        listAbsensiPegawai.value = absensiPegawaiFromJson(value.bodyString!);
        // log(value.bodyString!);
      }),
    );
  }
}
