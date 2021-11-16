import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/controller/riwayat_penghargaan_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class RiwayatPenghargaan extends StatelessWidget {
  const RiwayatPenghargaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RiwayatPenghargaanController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Riwayat Penghargaan',
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
                                Text(e!.namaPenghargaan!),
                                onTap: () async => await c.launchURL(
                                    'https://simrs.rsbhayangkaranganjuk.com/webapps/penggajian/' +
                                        e.berkas!),
                              ),
                              DataCell(
                                Text(
                                  DateFormat('dd/MM/yyyy').format(e.tanggal!),
                                ),
                              ),
                              DataCell(
                                Text(e.instansi!),
                              ),
                              DataCell(
                                Text(e.pejabatPemberi!),
                              ),
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
