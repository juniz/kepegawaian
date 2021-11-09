import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kepegawaian/controller/informasi_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/component/WACardComponent.dart';
import 'package:kepegawaian/component/WATransactionComponent.dart';
import 'package:kepegawaian/component/WAWalletUserListComponent.dart';
import 'package:kepegawaian/model/WalletAppModel.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/WADataGenerator.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';

class WAWalletScreen extends StatefulWidget {
  static String tag = '/WAWalletScreen';

  @override
  WAWalletScreenState createState() => WAWalletScreenState();
}

class WAWalletScreenState extends State<WAWalletScreen> {
  final c = Get.put(InformasiController());
  // List<WAWalletUserModel> walletUserList = waWalletUserList();
  // List<WACardModel> walletList = waCardList();
  // List<WATransactionModel> transactionList = waTransactionList();

  PageController? pageController;
  int currentPosition = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    pageController =
        PageController(initialPage: currentPosition, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
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
          title: Text(
            'Informasi',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
          // actions: [
          //   Container(
          //     height: 35,
          //     width: 35,
          //     margin: EdgeInsets.only(right: 16, top: 16),
          //     padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          //     decoration: boxDecorationRoundedWithShadow(8),
          //     child: waCommonCachedNetworkImage(
          //         'images/walletApp/wa_add_icon.png',
          //         fit: BoxFit.fill),
          //   ),
          // ],
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: c.listWebContents.value
                    .where((e) => e.betterFeaturedImage != null)
                    .map(
                      (e) => InkWell(
                        onTap: () => c.launchURL(e.link!),
                        child: Container(
                          width: Get.width,
                          height: Get.height / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(e
                                  .betterFeaturedImage!
                                  .mediaDetails!
                                  .sizes!['medium_large']!
                                  .sourceUrl!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(e.title!.rendered!,
                                      style: boldTextStyle(
                                          color: Colors.white, size: 15))
                                  .paddingOnly(left: 16, right: 16, bottom: 16),
                            ],
                          ),
                        ).paddingOnly(left: 16, right: 16, bottom: 20),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
