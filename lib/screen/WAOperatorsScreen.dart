import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/component/WAOperationComponent.dart';
import 'package:kepegawaian/model/WalletAppModel.dart';
import 'package:kepegawaian/utils/WADataGenerator.dart';

class WAOperatorsScreen extends StatefulWidget {
  static String tag = '/WAOperatorsScreen';

  @override
  WAOperatorsScreenState createState() => WAOperatorsScreenState();
}

class WAOperatorsScreenState extends State<WAOperatorsScreen> {
  List<WAOperationsModel> operationsList = waOperationList();

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Menu',
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
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          decoration: boxDecorationRoundedWithShadow(
            16,
            backgroundColor: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: operationsList.map((item) {
                return Container(
                  padding:
                      EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
                  decoration: boxDecorationRoundedWithShadow(16),
                  alignment: AlignmentDirectional.center,
                  width: Get.width * 0.27,
                  child: WAOperationComponent(
                    itemModel: item,
                  ),
                ).onTap(() {
                  Get.toNamed(item.widget!);
                });
              }).toList(),
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
