import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepegawaian/component/WAStatisticsChartComponent.dart';
import 'package:kepegawaian/component/WAStatisticsComponent.dart';
import 'package:kepegawaian/controller/chart_controller.dart';
import 'package:kepegawaian/controller/home_controller.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:outlined_text/outlined_text.dart';

class WAHomeScreen extends StatefulWidget {
  static String tag = '/WAHomeScreen';

  @override
  WAHomeScreenState createState() => WAHomeScreenState();
}

class WAHomeScreenState extends State<WAHomeScreen> {
  final c = Get.put(HomeController());
  final b = Get.put(ChartController());
  // List<WACardModel> cardList = waCardList();
  // List<WAOperationsModel> operationsList = waOperationList();
  // List<WATransactionModel> transactionList = waTransactionList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.height,
                Container(
                  width: Get.width,
                  height: Get.height / 4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/walletApp/kta.jpg'),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(color: Colors.white),
                    borderRadius: radius(10.0),
                    boxShadow: defaultBoxShadow(
                      shadowColor: Color(0xFFFF7426).withAlpha(50),
                      blurRadius: 10.0,
                      spreadRadius: 4.0,
                      offset: const Offset(0.0, 0.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'KARTU TANDA ANGGOTA',
                        style:
                            boldTextStyle(color: Colors.transparent, size: 18),
                      ).paddingOnly(left: 50, top: 10, bottom: 20),
                      10.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => waCommonCachedNetworkImage(
                              'https://webapps.rsbhayangkaranganjuk.com/webapps/penggajian/${c.photo.value}',
                              fit: BoxFit.fill,
                              height: 100,
                              width: 70,
                            ),
                          ).paddingOnly(left: 16, right: 10),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutlinedText(
                                  text: Text(
                                    'Nama',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                    maxLines: 1,
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    'NIP',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    'Tgl Lahir',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    'Alamat',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                )
                              ],
                            ),
                          ).expand(flex: 2),
                          Container(
                            child: Column(
                              children: [
                                OutlinedText(
                                  text: Text(
                                    ':',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    ':',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    ':',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    ':',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                              ],
                            ),
                          ).expand(flex: 1),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutlinedText(
                                  text: Text(
                                    c.nama.value,
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    c.nik.value,
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    '${c.tmpLahir.value}, ${c.tglLahir.value}',
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                                OutlinedText(
                                  text: Text(
                                    c.alamat.value,
                                    style: boldTextStyle(
                                        size: 12, color: Colors.black),
                                  ),
                                  strokes: [
                                    OutlinedTextStroke(
                                        color: Colors.white, width: 3),
                                  ],
                                ),
                              ],
                            ),
                          ).expand(flex: 5),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: OutlinedText(
                          text: Text(
                            'Masa Berlaku : Selama Jadi Pegawai',
                            style: boldTextStyle(size: 12, color: Colors.black),
                          ),
                          strokes: [
                            OutlinedTextStroke(color: Colors.white, width: 3),
                          ],
                        ).paddingLeft(50),
                      ),
                    ],
                  ).paddingOnly(right: 16),
                ).onTap(() {
                  
                }).paddingOnly(left: 16, right: 16, top: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Grafik ${b.chart.value} Saya',
                        style: boldTextStyle(size: 20),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      child: DropdownButtonFormField(
                        value: b.chart.value,
                        isExpanded: true,
                        decoration: waInputDecoration(
                            bgColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 8)),
                        items: <String>['Cuti', 'Izin'].map((String? value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value!, style: boldTextStyle(size: 14)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          b.chart.value = value.toString();
                          b.getJmlCuti();
                        },
                      ),
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16, top: 16),
                WAStatisticsChartComponent(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
                      style: boldTextStyle(size: 20),
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16),
                16.height,
                WAStatisticsComponent(),
                25.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
