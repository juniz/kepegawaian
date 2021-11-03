import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/component/WAStatisticsChartComponent.dart';
import 'package:kepegawaian/component/WAStatisticsComponent.dart';
import 'package:kepegawaian/component/grafik_izin.dart';
import 'package:kepegawaian/controller/chart_controller.dart';
import 'package:kepegawaian/controller/home_controller.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Icon(Icons.person),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Icon(Icons.add_alert, color: Colors.grey),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF7426),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                Obx(() => Text(c.nama.value, style: secondaryTextStyle())
                    .paddingOnly(left: 16, right: 16)),
                Text('Selamat Datang', style: boldTextStyle(size: 20))
                    .paddingOnly(left: 16, right: 16),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Wrap(
                //     direction: Axis.horizontal,
                //     spacing: 16,
                //     children: cardList.map((cardItem) {
                //       return WACardComponent(cardModel: cardItem);
                //     }).toList(),
                //   ).paddingAll(16),
                // ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Grafik ${b.chart.value}',
                        style: boldTextStyle(size: 20),
                      ),
                    ),
                    16.height,
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
                // Text('Grafik Izin', style: boldTextStyle(size: 20))
                //     .paddingOnly(left: 16, right: 16),
                // GrafikIzin(),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Menu', style: boldTextStyle(size: 20)),
                    // Icon(Icons.play_arrow, color: Colors.grey).onTap(() {
                    //   WAOperatorsScreen().launch(context);
                    // }),
                  ],
                ).paddingOnly(left: 16, right: 16),
                16.height,
                WAStatisticsComponent(),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Wrap(
                //     direction: Axis.horizontal,
                //     spacing: 16,
                //     children: operationsList.map((operationModel) {
                //       return WAOperationComponent(itemModel: operationModel)
                //           .onTap(() {
                //         operationModel.widget != null
                //             ? operationModel.widget.launch(context)
                //             : toast(operationModel.title);
                //       });
                //     }).toList(),
                //   ).paddingAll(16),
                // ),
                25.height,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text('Pengumuman', style: boldTextStyle(size: 20)),
                //     Icon(Icons.play_arrow, color: Colors.grey),
                //   ],
                // ).paddingOnly(left: 16, right: 16),
                // 16.height,
                // Column(
                //   children: transactionList.map((transactionItem) {
                //     return WATransactionComponent(
                //         transactionModel: transactionItem);
                //   }).toList(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
