import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/controller/statistik_controller.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';

class Statistik extends StatelessWidget {
  const Statistik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(StatistikController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Statistik Rumah Sakit',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('images/walletApp/wa_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: RefreshIndicator(
            onRefresh: () => c.onRefresh(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: boxDecorationRoundedWithShadow(12,
                        backgroundColor: Colors.red.withOpacity(0.1)),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.red),
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          child: Icon(AntDesign.dashboard, color: Colors.white),
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Kunjungan',
                                style: boldTextStyle(size: 14)),
                            4.height,
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                      NumberFormat('#,000')
                                          .format(c.kunjungan.value),
                                      style: boldTextStyle(size: 18)),
                                ),
                                5.width,
                                // Icon(AntDesign.arrowup, size: 15,)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Container(
                    decoration: boxDecorationRoundedWithShadow(12,
                        backgroundColor: Colors.blue.withOpacity(0.1)),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.blue),
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          child: Icon(AntDesign.home, color: Colors.white),
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kunjungan Tahun Ini',
                                style: boldTextStyle(size: 14)),
                            4.height,
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                    NumberFormat('#,000')
                                        .format(c.kunjunganTahunIni.value),
                                    style: boldTextStyle(size: 18),
                                  ),
                                ),
                                5.width,
                                Obx(
                                  () => Icon(
                                    c.perKunjunganTahunIni.value.isNegative
                                        ? AntDesign.arrowdown
                                        : AntDesign.arrowup,
                                    size: 15,
                                    color:
                                        c.perKunjunganTahunIni.value.isNegative
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    '(${c.perKunjunganTahunIni.value.toString()}%)',
                                    style: boldTextStyle(
                                      size: 18,
                                      color: c.perKunjunganTahunIni.value
                                              .isNegative
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Container(
                    decoration: boxDecorationRoundedWithShadow(12,
                        backgroundColor: Colors.purple.withOpacity(0.1)),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.purple),
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          child:
                              Icon(Icons.people_outline, color: Colors.white),
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kunjungan Bulan Ini',
                                style: boldTextStyle(size: 14)),
                            4.height,
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                    NumberFormat('#,000')
                                        .format(c.kunjunganBulanIni.value),
                                    style: boldTextStyle(size: 18),
                                  ),
                                ),
                                5.width,
                                Obx(
                                  () => Icon(
                                    c.perKunjunganBulanIni.value.isNegative
                                        ? AntDesign.arrowdown
                                        : AntDesign.arrowup,
                                    size: 15,
                                    color:
                                        c.perKunjunganBulanIni.value.isNegative
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    '(${c.perKunjunganBulanIni.value.toString()}%)',
                                    style: boldTextStyle(
                                      size: 18,
                                      color: c.perKunjunganBulanIni.value
                                              .isNegative
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Container(
                    decoration: boxDecorationRoundedWithShadow(12,
                        backgroundColor: Colors.green.withOpacity(0.1)),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.green),
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          child: Icon(AntDesign.calendar, color: Colors.white),
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kunjungan Hari Ini',
                                style: boldTextStyle(size: 14)),
                            4.height,
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                    NumberFormat('#,000')
                                        .format(c.kunjunganHariIni.value),
                                    style: boldTextStyle(size: 18),
                                  ),
                                ),
                                5.width,
                                Obx(
                                  () => Icon(
                                    c.perKunjunganHariIni.value.isNegative
                                        ? AntDesign.arrowdown
                                        : AntDesign.arrowup,
                                    size: 15,
                                    color:
                                        c.perKunjunganHariIni.value.isNegative
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    '(${c.perKunjunganHariIni.value}%)',
                                    style: boldTextStyle(
                                      size: 18,
                                      color:
                                          c.perKunjunganHariIni.value.isNegative
                                              ? Colors.red
                                              : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Text(
                    'Jumlah Kunjungan Poliklinik Hari Ini',
                    style: boldTextStyle(size: 20),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  Obx(
                    () => Column(
                      children: c.jmlPasienPoli.value
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: Container(
                                decoration: boxDecorationRoundedWithShadow(12,
                                    backgroundColor:
                                        WAPrimaryColor.withOpacity(0.1)),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                              backgroundColor: WAPrimaryColor),
                                      height: 45,
                                      width: 45,
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(Icons.local_hospital,
                                          color: Colors.white),
                                    ),
                                    10.width,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.nmPoli!,
                                            style: boldTextStyle(size: 14)),
                                        4.height,
                                        Row(
                                          children: [
                                            Text(
                                              '${e.jumlah!.toString()} Pasien',
                                              style: boldTextStyle(
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
