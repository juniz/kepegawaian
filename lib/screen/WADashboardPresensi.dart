import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sdm_handal/controller/dashboard_presensi_controller.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
          child: Container(
            height: 300,
            child: Obx(
              () => SfCartesianChart(
                zoomPanBehavior: controller.zoomPanBehavior,
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  maximumLabels: 50,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  labelRotation: 90,
                ),
                tooltipBehavior: controller.tooltipBehavior,
                series: <CartesianSeries>[
                  ColumnSeries<AbsensiUnit, String>(
                    color: Colors.green,
                    dataSource: controller.listAbsensiUnit.value,
                    xValueMapper: (AbsensiUnit data, _) => data.depId,
                    yValueMapper: (AbsensiUnit data, _) => data.tepatWaktu!,
                    enableTooltip: true,
                  ),
                  ColumnSeries<AbsensiUnit, String>(
                    dataSource: controller.listAbsensiUnit.value,
                    xValueMapper: (AbsensiUnit data, _) => data.depId,
                    yValueMapper: (AbsensiUnit data, _) => data.toleransi!,
                    enableTooltip: true,
                  ),
                  ColumnSeries<AbsensiUnit, String>(
                    dataSource: controller.listAbsensiUnit.value,
                    xValueMapper: (AbsensiUnit data, _) => data.depId,
                    yValueMapper: (AbsensiUnit data, _) => data.terlambat1!,
                    enableTooltip: true,
                  ),
                  ColumnSeries<AbsensiUnit, String>(
                    dataSource: controller.listAbsensiUnit.value,
                    xValueMapper: (AbsensiUnit data, _) => data.depId,
                    yValueMapper: (AbsensiUnit data, _) => data.terlambat2,
                    enableTooltip: true,
                  )
                ],
              ),
            ),
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
