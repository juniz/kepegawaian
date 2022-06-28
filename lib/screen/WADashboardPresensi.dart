import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/dashboard_presensi_controller.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/rekap_presensi_controller.dart';
import '../model/absensi_pegawai_model.dart';
import '../utils/WAColors.dart';
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
                  height: Get.height * 0.9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GFButton(
                            onPressed: () {
                              controller.getAbsensiTepatWaktu();
                              modalPresensiTepatWaktu(context, controller);
                            },
                            text: 'Tepat Waktu',
                            color: GFColors.SUCCESS,
                            type: GFButtonType.outline,
                            size: GFSize.LARGE,
                          ).paddingOnly(bottom: 2, right: 5).flexible(flex: 3),
                          GFButton(
                            onPressed: () {
                              controller.getAbsensiTerlambat();
                              modalPresensiTerlambat(context, controller);
                            },
                            text: 'Terlambat',
                            color: GFColors.DANGER,
                            type: GFButtonType.outline,
                            size: GFSize.LARGE,
                          ).paddingOnly(bottom: 2, right: 5).flexible(flex: 2),
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
                          ).paddingOnly(bottom: 2, right: 5).flexible(flex: 2),
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
                          ).paddingOnly(bottom: 2, right: 5).flexible(flex: 2),
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
                            // labelRotation: 90,
                          ),
                          tooltipBehavior: controller.tooltipBehavior,
                          legend: Legend(
                              title: LegendTitle(
                                text: 'Keterangan',
                                textStyle: boldTextStyle(),
                              ),
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              borderColor: Colors.black,
                              borderWidth: 1,
                              position: LegendPosition.bottom),
                          series: <CartesianSeries>[
                            BarSeries<AbsensiUnit, String>(
                              legendItemText: 'Tepat Waktu',
                              color: Colors.green,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.tepatWaktu!,
                              enableTooltip: true,
                              onPointTap: (ChartPointDetails details) {
                                controller.getAbsensiPegawai(
                                    details.dataPoints?[details.pointIndex!].x);
                                modalPresensiPegawai(
                                    context, controller, details);
                              },
                            ),
                            BarSeries<AbsensiUnit, String>(
                              legendItemText: 'Toleransi',
                              color: Colors.yellow,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.toleransi!,
                              enableTooltip: true,
                              onPointTap: (ChartPointDetails details) {
                                controller.getAbsensiPegawai(
                                    details.dataPoints?[details.pointIndex!].x);
                                modalPresensiPegawai(
                                    context, controller, details);
                              },
                            ),
                            BarSeries<AbsensiUnit, String>(
                              legendItemText: 'Terlambat I',
                              color: Colors.red.shade400,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.terlambat1!,
                              enableTooltip: true,
                              onPointTap: (ChartPointDetails details) {
                                controller.getAbsensiPegawai(
                                    details.dataPoints?[details.pointIndex!].x);
                                modalPresensiPegawai(
                                    context, controller, details);
                              },
                            ),
                            BarSeries<AbsensiUnit, String>(
                              legendItemText: 'Terlambat II',
                              color: Colors.red.shade900,
                              dataSource: controller.listAbsensiUnit.value,
                              xValueMapper: (AbsensiUnit data, _) => data.depId,
                              yValueMapper: (AbsensiUnit data, _) =>
                                  data.terlambat2,
                              enableTooltip: true,
                              onPointTap: (ChartPointDetails details) {
                                controller.getAbsensiPegawai(
                                    details.dataPoints?[details.pointIndex!].x);
                                modalPresensiPegawai(
                                    context, controller, details);
                              },
                            )
                          ],
                        ).flexible(flex: 10),
                      ),
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

  Future<dynamic> modalPresensiPegawai(BuildContext context,
      DashboardPresensiController controller, ChartPointDetails details) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.96,
            child: Scaffold(
              appBar: GFAppBar(
                title: Text(
                    controller.listAbsensiUnit.value[details.pointIndex!].nama!,
                    style: boldTextStyle(color: Colors.white)),
                backgroundColor: WAPrimaryColor,
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
              ),
              body: Container(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.listAbsensiPegawai.length,
                    itemBuilder: (context, index) {
                      final f = NumberFormat("###.#");
                      return Card(
                        child: GFListTile(
                          margin: const EdgeInsets.all(0),
                          title: Text(
                              controller.listAbsensiPegawai.value[index].nama!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis),
                          avatar: Column(
                            children: [
                              waCommonCachedNetworkImage(
                                'https://simrs.rsbhayangkaranganjuk.com/webapps/penggajian/${controller.listAbsensiPegawai.value[index].photo}',
                                height: 100,
                                width: 80,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Total : ${controller.listAbsensiPegawai.value[index].total}',
                                style: boldTextStyle(),
                              )
                            ],
                          ),
                          description: Column(
                            children: [
                              GFProgressBar(
                                      lineHeight: 20,
                                      child: Text(
                                        '${controller.listAbsensiPegawai.value[index].tepatWaktu}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      leading: Text(
                                        "Tepat Waktu",
                                        style: primaryTextStyle(size: 14),
                                      ).withWidth(90),
                                      percentage: controller.listAbsensiPegawai
                                              .value[index].tepatWaktu!
                                              .toDouble() /
                                          controller.listAbsensiPegawai
                                              .value[index].total!
                                              .toDouble(),
                                      backgroundColor: Colors.black26,
                                      progressBarColor: GFColors.SUCCESS)
                                  .withTooltip(
                                      msg:
                                          "Tepat Waktu : ${controller.listAbsensiPegawai.value[index].tepatWaktu}")
                                  .paddingSymmetric(vertical: 5),
                              GFProgressBar(
                                      lineHeight: 20,
                                      child: Text(
                                        '${controller.listAbsensiPegawai.value[index].toleransi}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      leading: Text(
                                        "Toleransi",
                                        style: primaryTextStyle(size: 14),
                                      ).withWidth(90),
                                      percentage: controller.listAbsensiPegawai
                                              .value[index].toleransi!
                                              .toDouble() /
                                          controller.listAbsensiPegawai
                                              .value[index].total!
                                              .toDouble(),
                                      backgroundColor: Colors.black26,
                                      progressBarColor: GFColors.WARNING)
                                  .withTooltip(
                                      msg:
                                          "Toleransi : ${controller.listAbsensiPegawai.value[index].toleransi}")
                                  .paddingSymmetric(vertical: 5),
                              GFProgressBar(
                                      lineHeight: 20,
                                      child: Text(
                                        '${controller.listAbsensiPegawai.value[index].terlambat1}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      leading: Text(
                                        "Terlambat I",
                                        style: primaryTextStyle(size: 14),
                                      ).withWidth(90),
                                      percentage: controller.listAbsensiPegawai
                                              .value[index].terlambat1!
                                              .toDouble() /
                                          controller.listAbsensiPegawai
                                              .value[index].total!
                                              .toDouble(),
                                      backgroundColor: Colors.black26,
                                      progressBarColor: GFColors.DANGER)
                                  .withTooltip(
                                      msg:
                                          "Terlambat I : ${controller.listAbsensiPegawai.value[index].terlambat1}")
                                  .paddingSymmetric(vertical: 5),
                              GFProgressBar(
                                      lineHeight: 20,
                                      child: Text(
                                        '${controller.listAbsensiPegawai.value[index].terlambat2}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      leading: Text(
                                        "Terlambat II",
                                        style: primaryTextStyle(size: 14),
                                      ).withWidth(90),
                                      percentage: controller.listAbsensiPegawai
                                              .value[index].terlambat2!
                                              .toDouble() /
                                          controller.listAbsensiPegawai
                                              .value[index].total!
                                              .toDouble(),
                                      backgroundColor: Colors.black26,
                                      progressBarColor: GFColors.DANGER)
                                  .withTooltip(
                                      msg:
                                          "Terlambat II : ${controller.listAbsensiPegawai.value[index].terlambat2}")
                                  .paddingSymmetric(vertical: 5),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> modalPresensiTerlambat(
      BuildContext context, DashboardPresensiController controller) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.96,
          child: Scaffold(
            appBar: GFAppBar(
              title: Text("DAFTAR PEGAWAI TERLAMBAT",
                  style: boldTextStyle(color: Colors.white)),
              backgroundColor: WAPrimaryColor,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
            body: Container(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.listAbsensiTerlambat.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GFListTile(
                        margin: const EdgeInsets.all(0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                  .listAbsensiTerlambat.value[index].nama!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.listAbsensiTerlambat.value[index]
                                  .departemen!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        avatar: waCommonCachedNetworkImage(
                          'https://simrs.rsbhayangkaranganjuk.com/webapps/penggajian/${controller.listAbsensiTerlambat.value[index].photo}',
                          height: 100,
                          width: 80,
                        ),
                        description: Column(
                          children: [
                            GFProgressBar(
                              percentage: 1,
                              lineHeight: 20,
                              leading: Text('Total', style: boldTextStyle())
                                  .withWidth(85),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '${controller.listAbsensiTerlambat.value[index].total}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.black26,
                              progressBarColor: GFColors.PRIMARY,
                            ).paddingSymmetric(vertical: 5),
                            GFProgressBar(
                              leading: Text('Terlambat', style: boldTextStyle())
                                  .withWidth(85),
                              percentage: controller.listAbsensiTerlambat
                                      .value[index].totalTerlambat!
                                      .toDouble() /
                                  controller
                                      .listAbsensiTerlambat.value[index].total!
                                      .toDouble(),
                              lineHeight: 20,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '${controller.listAbsensiTerlambat.value[index].totalTerlambat!}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.black26,
                              progressBarColor: GFColors.DANGER,
                            ).paddingSymmetric(vertical: 5),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> modalPresensiTepatWaktu(
      BuildContext context, DashboardPresensiController controller) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.96,
          child: Scaffold(
            appBar: GFAppBar(
              title: Text("DAFTAR PEGAWAI TEPAT WAKTU",
                  style: boldTextStyle(color: Colors.white)),
              backgroundColor: WAPrimaryColor,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
            body: Container(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.listAbsensiTepatWaktu.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GFListTile(
                        margin: const EdgeInsets.all(0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                  .listAbsensiTepatWaktu.value[index].nama!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.listAbsensiTepatWaktu.value[index]
                                  .departemen!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        avatar: waCommonCachedNetworkImage(
                          'https://simrs.rsbhayangkaranganjuk.com/webapps/penggajian/${controller.listAbsensiTepatWaktu.value[index].photo}',
                          height: 100,
                          width: 80,
                        ),
                        description: Column(
                          children: [
                            GFProgressBar(
                              percentage: 1,
                              lineHeight: 20,
                              leading: Text('Total',
                                      style: primaryTextStyle(size: 14))
                                  .withWidth(85),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '${controller.listAbsensiTepatWaktu.value[index].total}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.black26,
                              progressBarColor: GFColors.PRIMARY,
                            ).paddingSymmetric(vertical: 5),
                            GFProgressBar(
                              percentage: 1,
                              lineHeight: 20,
                              leading: Text('Tepat Waktu',
                                      style: primaryTextStyle(size: 14))
                                  .withWidth(85),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  '${controller.listAbsensiTepatWaktu.value[index].tepatWaktu}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.black26,
                              progressBarColor: GFColors.SUCCESS,
                            ).paddingSymmetric(vertical: 5),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
