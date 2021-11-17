import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdm_handal/controller/chart_izin_controller.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

class GrafikIzin extends StatelessWidget {
  const GrafikIzin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ChartIzinController());

    int touchedGroupIndex = -1;
    return Container(
      height: 250,
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Obx(
        () => BarChart(
          BarChartData(
            maxY: 5,
            gridData:
                FlGridData(drawHorizontalLine: true, drawVerticalLine: true),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'Mei';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Agu';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Okt';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Des';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(
                showTitles: true,
                margin: 20,
                reservedSize: 2,
                getTitles: (value) {
                  if (value == 0) {
                    return '0';
                  } else if (value == 1) {
                    return '1';
                  } else if (value == 2) {
                    return '2';
                  } else if (value == 3) {
                    return '3';
                  } else if (value == 4) {
                    return '4';
                  } else if (value == 5) {
                    return '5';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: c.showingBarGroups.value,
          ),
          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear,
        ).center(),
      ).paddingAll(16).center(),
    );
  }
}
