import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdm_handal/component/WAOperationComponent.dart';
import 'package:sdm_handal/component/WAStatisticsChartComponent.dart';
import 'package:sdm_handal/controller/chart_controller.dart';
import 'package:sdm_handal/controller/home_controller.dart';
import 'package:sdm_handal/model/WalletAppModel.dart';
import 'package:sdm_handal/screen/WAOperatorsScreen.dart';
import 'package:sdm_handal/utils/WADataGenerator.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/WAUrl.dart';

class WAHomeScreen extends StatefulWidget {
  static String tag = '/WAHomeScreen';

  @override
  WAHomeScreenState createState() => WAHomeScreenState();
}

class WAHomeScreenState extends State<WAHomeScreen> {
  final c = Get.put(HomeController());
  final b = Get.put(ChartController());
  // List<WACardModel> cardList = waCardList();
  List<WAOperationsModel> operationsList = waOperationList();
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
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('images/walletApp/kta.jpg'),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(color: Colors.white),
                    borderRadius: radius(10.0),
                    boxShadow: defaultBoxShadow(
                      shadowColor: const Color(0xFFFF7426).withAlpha(50),
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
                            () => Container(
                              width: 70,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                    urlBaseImage + c.photo.value,
                                  ),
                                ),
                              ),
                            ).paddingOnly(left: 16, right: 10),
                          ),

                          //   waCommonCachedNetworkImage(
                          //     'https://webapps.rsbhayangkaranganjuk.com/webapps/penggajian/${c.photo.value}',
                          //     fit: BoxFit.fill,
                          //     height: 100,
                          //     width: 70,
                          //   ),
                          // ).paddingOnly(left: 16, right: 10),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                  maxLines: 1,
                                ),
                                Text(
                                  'NIP',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  'Tgl Lahir',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  'Alamat',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ).expand(flex: 2),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  ':',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  ':',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  ':',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  ':',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
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
                                  style: boldTextStyle(
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  c.nik.value,
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  '${c.tmpLahir.value}, ${c.tglLahir.value}',
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                                Text(
                                  c.alamat.value,
                                  style: boldTextStyle(
                                      size: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ).expand(flex: 5),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'KARTU INI BERLAKU SELAMA PEMEGANG KARTU MENJADI ANGGOTA RS BHAYANGKARA NGANJUK',
                          style: boldTextStyle(size: 10, color: Colors.black),
                          textAlign: TextAlign.center,
                        ).paddingOnly(left: 16, right: 16, top: 2),
                      ),
                    ],
                  ).paddingOnly(right: 16),
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
                    const Icon(Icons.play_arrow, color: Colors.grey).onTap(() {
                      WAOperatorsScreen().launch(context);
                    }),
                  ],
                ).paddingOnly(left: 16, right: 16),
                // 16.height,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 16,
                    children: operationsList.map((operationModel) {
                      if (!operationModel.role.isEmptyOrNull) {
                        // log(operationModel.role);
                        if (operationModel.role! == c.departemen.value) {
                          return WAOperationComponent(itemModel: operationModel)
                              .onTap(() {
                            operationModel.widget != null
                                ? Get.toNamed(operationModel.widget!)
                                : toast(operationModel.title);
                          });
                        } else {
                          return Container();
                        }
                      } else {
                        return WAOperationComponent(itemModel: operationModel)
                            .onTap(() {
                          operationModel.widget != null
                              ? Get.toNamed(operationModel.widget!)
                              : toast(operationModel.title);
                        });
                      }
                      // return Container();
                      // return WAOperationComponent(itemModel: operationModel)
                      //     .onTap(() {
                      //   operationModel.widget != null
                      //       ? Get.toNamed(operationModel.widget!)
                      //       : toast(operationModel.title);
                      // });
                    }).toList(),
                  ).paddingAll(16),
                ),
                //WAStatisticsComponent(),
                80.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
