import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/jadwal_rapat_controller.dart';
import 'package:sdm_handal/utils/WAColors.dart';

class RapatScreen extends StatelessWidget {
  const RapatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalRapatController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Rapat',
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
          child: Obx(
            () => controller.listJadwalRapat.value.isEmpty
                ? Center(
                    child:
                        Lottie.asset('images/lottie/no-data-found-json.json'),
                  )
                : Column(
                    children: controller.listJadwalRapat.value
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(e.pimpinan!,
                                          style: boldTextStyle(size: 12)),
                                      4.height,
                                      Text(
                                        e.agenda!,
                                        style: boldTextStyle(
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ).flexible(flex: 6),
                                  10.width,
                                  Container(
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: e.stts == "0"
                                          ? WAPrimaryColor
                                          : Colors.red,
                                    ),
                                    height: 45,
                                    width: 45,
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(Icons.input,
                                        color: Colors.white),
                                  ).flexible(),
                                ],
                              ),
                            ),
                          ).onTap(
                            () => showConfirmDialog(
                              context,
                              'Anda yakin ingin menghadiri rapat tentang "${e.agenda}"',
                              buttonColor: WAPrimaryColor,
                              onAccept: () {
                                //Get.back();
                                controller.hadirRapat(e.id!);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
