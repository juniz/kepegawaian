import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/jadwal_pegawai_controlller.dart';
import 'package:sdm_handal/model/jadwal_pegawai_model.dart';
import 'package:sdm_handal/model/jam_masuk_model.dart';
import 'package:sdm_handal/utils/WAColors.dart';

class JadwalPegawai extends StatelessWidget {
  const JadwalPegawai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalPegawaiController());
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Jadwal Pegawai',
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
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 31,
                  physics: const BouncingScrollPhysics(
                    parent: ScrollPhysics(),
                  ),
                  primary: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() => Jadwal(
                          tanggal: index + 1,
                          jamMasuk: controller.listJamMasuk.value,
                          jadwalPegawai: controller.jadwalPegawai.value,
                        ).paddingSymmetric(horizontal: 16));
                  },
                ),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Jadwal extends StatelessWidget {
  const Jadwal({
    this.jamMasuk,
    this.tanggal,
    this.jadwalPegawai,
  });

  final int? tanggal;
  final List<JamMasukModel>? jamMasuk;
  final Map<dynamic, dynamic>? jadwalPegawai;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JadwalPegawaiController>();
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: boxDecorationRoundedWithShadow(10,
              backgroundColor: WAPrimaryColor),
          child: Text(tanggal.toString(),
                  style: boldTextStyle(size: 24, color: white))
              .center(),
        ).flexible(),
        Container(
          height: 50,
          width: Get.width,
          margin: EdgeInsets.all(20),
          child: DropdownButtonHideUnderline(
            child: GFDropdown(
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(10),
              border: const BorderSide(color: Colors.black12, width: 1),
              dropdownButtonColor: Colors.grey[300],
              onChanged: (newValue) {
                //print(newValue.toString());
                controller.updateJadwalPegawai(tanggal, newValue.toString());
              },
              value: jadwalPegawai?['h${tanggal}'],
              items: jamMasuk
                  ?.map((value) => DropdownMenuItem(
                        value: value.shift,
                        child: Text(
                          value.shift != ''
                              ? '${value.shift} [${value.jamMasuk} - ${value.jamPulang}]'
                              : '',
                          style: primaryTextStyle(size: 12),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ).flexible(flex: 5),
      ],
    );
  }
}
