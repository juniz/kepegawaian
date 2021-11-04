import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/component/WAStatisticsChartComponent.dart';
import 'package:kepegawaian/component/WAStatisticsComponent.dart';
import 'package:kepegawaian/component/grafik_izin.dart';
import 'package:kepegawaian/controller/chart_controller.dart';
import 'package:kepegawaian/controller/home_controller.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/component/WACardComponent.dart';
import 'package:kepegawaian/component/WAOperationComponent.dart';
import 'package:kepegawaian/component/WATransactionComponent.dart';
import 'package:kepegawaian/model/WalletAppModel.dart';
import 'package:kepegawaian/screen/WAOperatorsScreen.dart';
import 'package:kepegawaian/utils/WADataGenerator.dart';

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
                  decoration: boxDecorationRoundedWithShadow(
                    10,
                    backgroundColor: Color(0xFFFF7426),
                    blurRadius: 10.0,
                    spreadRadius: 4.0,
                    shadowColor: Color(0xFFFF7426).withAlpha(50),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'KARTU TANDA ANGGOTA',
                        style: boldTextStyle(color: Colors.white, size: 18),
                      ).paddingOnly(top: 10, bottom: 20),
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
                                Text(
                                  'Nama',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                  maxLines: 1,
                                ),
                                Text(
                                  'NIK',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  'Tgl Lahir',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  'Alamat',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ).expand(flex: 2),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  ':',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  ':',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  ':',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  ':',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ).expand(flex: 1),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.nama.value,
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                  maxLines: 1,
                                ),
                                Text(
                                  c.nik.value,
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  '${c.tmpLahir.value}, ${c.tglLahir.value}',
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                                Text(
                                  c.alamat.value,
                                  style: secondaryTextStyle(
                                      size: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ).expand(flex: 5),
                        ],
                      ),
                    ],
                  ),
                ).onTap(() {}).paddingOnly(left: 16, right: 16, top: 16),
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
