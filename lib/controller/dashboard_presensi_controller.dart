import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPresensiController extends GetConnect {
  final provider = Get.put(ApiConnection());
  final listAbsensiUnit = <AbsensiUnit>[].obs;
  var listBarAbsensiUnit = <BarChartGroupData>[].obs;
  late TooltipBehavior tooltipBehavior;
  late ZoomPanBehavior zoomPanBehavior;
  @override
  void onInit() {
    // TODO: implement onInit
    tooltipBehavior = TooltipBehavior(enable: true);
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
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
    var data = {'tanggal': '2022-05-'};
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
}
