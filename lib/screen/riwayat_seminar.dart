import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/controller/riwayat_seminar_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RiwayatSeminar extends StatelessWidget {
  const RiwayatSeminar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RiwayatSeminarController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Riwayat Seminar',
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
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => DataTable(
                    columns: c.headerTable.value,
                    rows: c.dataTable
                        .map(
                          (e) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text(e!.namaSeminar!),
                                onTap: () async => await launch(
                                    'https://webapps.rsbhayangkaranganjuk.com/webapps/penggajian/' +
                                        e.berkas!),
                              ),
                              DataCell(Text(e.peranan!)),
                              DataCell(
                                Text(
                                  DateFormat('dd/MM/yyyy').format(e.mulai!),
                                ),
                              ),
                              DataCell(Text(e.penyelengara!)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
