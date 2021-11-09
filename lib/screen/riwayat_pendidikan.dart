import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/controller/riwayat_pendidikan_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RiwayatPendidikanPage extends StatelessWidget {
  const RiwayatPendidikanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RiwayatPendidikanController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Riwayat Pendidikan',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
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
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/walletApp/wa_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            width: Get.width,
            height: Get.height,
            decoration: boxDecorationWithShadow(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: c.listRiwayatPendidikan.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        width: Get.height,
                        height: Get.height * 0.1,
                        child: TimelineTile(
                          alignment: TimelineAlign.manual,
                          isFirst: index == 0 ? true : false,
                          isLast:
                              index == c.listRiwayatPendidikan.value.length - 1
                                  ? true
                                  : false,
                          lineXY: 0.2,
                          startChild: Text(c
                              .listRiwayatPendidikan.value[index].thnLulus!
                              .toString()),
                          endChild: InkWell(
                            onTap: () => c.launchURL(
                                'https://webapps.rsbhayangkaranganjuk.com/webapps/penggajian/' +
                                    c.listRiwayatPendidikan.value[index]
                                        .berkas!),
                            child: Text(
                                    '(${c.listRiwayatPendidikan.value[index].status!}) ${c.listRiwayatPendidikan.value[index].sekolah!}')
                                .paddingLeft(16),
                          ),
                          indicatorStyle: IndicatorStyle(
                            color: index == 0 ? Colors.green : Colors.grey,
                          ),
                          beforeLineStyle:
                              LineStyle(color: Colors.grey, thickness: 1),
                          afterLineStyle:
                              LineStyle(color: Colors.grey, thickness: 1),
                        ),
                      );
                    },
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
