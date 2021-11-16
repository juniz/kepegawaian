import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:kepegawaian/controller/rengiat_controller.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';

class RengiatPage extends StatelessWidget {
  const RengiatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RengiatController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Daftar Rengiat',
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
          brightness: Brightness.dark,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: RefreshIndicator(
            onRefresh: () => c.getRengiat(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Obx(
                () => Column(
                  children: c.rengiatData.value
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
                                  decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: WAPrimaryColor),
                                  height: 45,
                                  width: 45,
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    FontAwesome5.clipboard,
                                    color: Colors.white,
                                  ).center(),
                                ).flexible(),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.namaGiat!,
                                      style: boldTextStyle(size: 12),
                                    ),
                                    4.height,
                                    // Text(
                                    //   e.hasilCapai!,
                                    //   style: boldTextStyle(size: 15),
                                    // ),
                                    RichText(
                                      overflow: TextOverflow.clip,
                                      text: TextSpan(
                                        style: boldTextStyle(size: 15),
                                        text: e.hasilCapai,
                                      ),
                                    ),
                                  ],
                                ).flexible(flex: 3),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
