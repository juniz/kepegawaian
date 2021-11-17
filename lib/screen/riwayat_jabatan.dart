import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/controller/riwayat_jabatan_controller.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RiwayatJabatan extends StatelessWidget {
  const RiwayatJabatan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RiwayatJabatanController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Riwayat Jabatan',
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
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
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
                    itemCount: c.listRiwayatJabatan.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.height,
                        height: Get.height * 0.1,
                        child: TimelineTile(
                          alignment: TimelineAlign.center,
                          isFirst: index == 0 ? true : false,
                          isLast: index == c.listRiwayatJabatan.value.length - 1
                              ? true
                              : false,
                          startChild: Text(
                              '${c.listRiwayatJabatan.value[index].nomorSk!}\n${DateFormat('dd-MM-yyyy').format(c.listRiwayatJabatan.value[index].tglSk!)}'),
                          endChild: InkWell(
                            onTap: () => c.launchURL(
                                'https://simrs.rsbhayangkaranganjuk.com/webapps/penggajian/' +
                                    c.listRiwayatJabatan.value[index].berkas!),
                            child:
                                Text(c.listRiwayatJabatan.value[index].jabatan!)
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
