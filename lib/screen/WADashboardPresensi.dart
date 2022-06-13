import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/dashboard_presensi_controller.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/rekap_presensi_controller.dart';
import '../model/absensi_pegawai_model.dart';
import '../utils/WAWidgets.dart';

class WADashboardPresensi extends StatelessWidget {
  const WADashboardPresensi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardPresensiController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Dashboard Presensi',
            style: boldTextStyle(color: Colors.black, size: 20)),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ).onTap(() {
          finish(context);
        }),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/walletApp/wa_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  height: Get.height * 0.7,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: Get.width / 3.5,
                            height: 50,
                            child: Obx(
                              () => DropdownButtonFormField(
                                value: controller.monthSelected.value,
                                isExpanded: true,
                                decoration: waInputDecoration(
                                    bgColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                items:
                                    controller.months.value.map((Bulan? value) {
                                  return DropdownMenuItem<String>(
                                    value: value!.bulan,
                                    child: Text(value.name!,
                                        style: boldTextStyle(size: 14)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.monthSelected.value =
                                      value.toString();
                                  controller.getAbsensiUnit();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: Get.width / 4,
                            height: 50,
                            child: Obx(
                              () => DropdownButtonFormField(
                                value: controller.yearSelected.value,
                                isExpanded: true,
                                decoration: waInputDecoration(
                                    bgColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                items:
                                    controller.years.value.map((String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value!,
                                    child: Text(value,
                                        style: boldTextStyle(size: 14)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.yearSelected.value =
                                      value.toString();
                                  controller.getAbsensiUnit();
                                },
                              ),
                            ),
                          ),
                        ],
                      ).flexible(),
                      Obx(
                        () => SfCartesianChart(
                          zoomPanBehavior: controller.zoomPanBehavior,
                          enableAxisAnimation: true,
                          primaryXAxis: CategoryAxis(
                            maximumLabels: 50,
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            labelIntersectAction:
                                AxisLabelIntersectAction.multipleRows,
                            labelRotation: 90,
                          ),
                          tooltipBehavior: controller.tooltipBehavior,
                          legend: Legend(
                              title: LegendTitle(
                                text: 'Jenis Keterlambatan',
                                textStyle: boldTextStyle(),
                              ),
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              borderColor: Colors.black,
                              borderWidth: 1,
                              position: LegendPosition.bottom),
                          series: <CartesianSeries>[
                            ColumnSeries<AbsensiUnit, String>(
                                legendItemText: 'Tepat Waktu',
                                color: Colors.green,
                                dataSource: controller.listAbsensiUnit.value,
                                xValueMapper: (AbsensiUnit data, _) =>
                                    data.depId,
                                yValueMapper: (AbsensiUnit data, _) =>
                                    data.tepatWaktu!,
                                enableTooltip: true,
                                onPointTap: (ChartPointDetails details) {
                                  print(details
                                      .dataPoints?[details.pointIndex!].x);
                                  controller.getAbsensiPegawai(details
                                      .dataPoints?[details.pointIndex!].x);
                                }),
                            ColumnSeries<AbsensiUnit, String>(
                              legendItemText: 'Toleransi',
                              color: Colors.yellow,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.toleransi!,
                              enableTooltip: true,
                            ),
                            ColumnSeries<AbsensiUnit, String>(
                              legendItemText: 'Terlambat I',
                              color: Colors.red.shade400,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.terlambat1!,
                              enableTooltip: true,
                            ),
                            ColumnSeries<AbsensiUnit, String>(
                              legendItemText: 'Terlambat II',
                              color: Colors.red.shade900,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.terlambat2,
                              enableTooltip: true,
                            )
                          ],
                        ).flexible(flex: 5),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 700,
                  child: Column(
                    children: [
                      Obx(() => SfCircularChart(
                            series: <CircularSeries>[
                              // Renders radial bar chart
                              RadialBarSeries<AbsensiPegawai, String>(
                                dataSource: <AbsensiPegawai>[
                                  controller.listAbsensiPegawai.value[3]
                                ],
                                xValueMapper: (AbsensiPegawai data, _) =>
                                    data.nama,
                                yValueMapper: (AbsensiPegawai data, _) =>
                                    data.tepatWaktu,
                                pointRadiusMapper: (AbsensiPegawai data, _) =>
                                    data.nama,
                              ),
                            ],
                          )),
                      Obx(() => SfCircularChart(
                            series: <CircularSeries>[
                              // Renders radial bar chart
                              RadialBarSeries<AbsensiPegawai, String>(
                                dataSource: controller.listAbsensiPegawai.value,
                                xValueMapper: (AbsensiPegawai data, _) =>
                                    data.nama,
                                yValueMapper: (AbsensiPegawai data, _) =>
                                    data.tepatWaktu,
                                pointRadiusMapper: (AbsensiPegawai data, _) =>
                                    data.nama,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
