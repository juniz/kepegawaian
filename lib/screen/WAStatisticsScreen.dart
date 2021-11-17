import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdm_handal/controller/rekap_presensi_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/component/WAStatisticsChartComponent.dart';
import 'package:sdm_handal/component/WAStatisticsComponent.dart';
import 'package:sdm_handal/model/WalletAppModel.dart';
import 'package:sdm_handal/component/WACategoriesComponent.dart';
import 'package:sdm_handal/utils/WADataGenerator.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';

class WAStatisticScreen extends StatefulWidget {
  static String tag = '/WAStatisticScreen';

  @override
  WAStatisticScreenState createState() => WAStatisticScreenState();
}

class WAStatisticScreenState extends State<WAStatisticScreen> {
  final c = Get.put(RekapPresensiController());
  List<WATransactionModel> categoriesList = waCategoriesList();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Rekap Presensi',
              style: boldTextStyle(color: Colors.black, size: 20)),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Presensi', style: boldTextStyle(size: 20)),
                    Container(
                      width: Get.width / 3.5,
                      height: 50,
                      child: Obx(
                        () => DropdownButtonFormField(
                          value: c.monthSelected,
                          isExpanded: true,
                          decoration: waInputDecoration(
                              bgColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 8)),
                          items: c.months.value.map((Bulan? value) {
                            return DropdownMenuItem<String>(
                              value: value!.bulan,
                              child: Text(value.name!,
                                  style: boldTextStyle(size: 14)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            c.monthSelected = value.toString();
                            c.getRekapPresensi();
                          },
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16),
                16.height,
                Obx(
                  () => Column(
                    children: c.listPresensi.value.map((categoryItem) {
                      return WACategoriesComponent(categoryModel: categoryItem);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
