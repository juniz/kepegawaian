import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepegawaian/controller/jadwal_dokter_controller.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';

class JadwalDokterPage extends StatelessWidget {
  const JadwalDokterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(JadwalDokterController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Jadwal Dokter Hari Ini',
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
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: c.listJadwalController.value
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Container(
                          decoration: boxDecorationRoundedWithShadow(12,
                              backgroundColor: WAPrimaryColor.withOpacity(0.1)),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: WAPrimaryColor),
                                height: 45,
                                width: 45,
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(
                                      e.jamMulai!,
                                      style: boldTextStyle(
                                          size: 12, color: Colors.white),
                                      maxLines: 1,
                                    ),
                                    5.height,
                                    Text(
                                      e.jamSelesai!,
                                      style: boldTextStyle(
                                          size: 12, color: Colors.white),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              10.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.nmPoli!,
                                    style: boldTextStyle(size: 12),
                                  ),
                                  4.height,
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: boldTextStyle(size: 15),
                                      text: e.nmDokter,
                                    ),
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
          ),
        ),
      ),
    );
  }
}
