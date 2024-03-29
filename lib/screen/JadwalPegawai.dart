import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/jadwal_pegawai_controlller.dart';
import 'package:sdm_handal/controller/rekap_presensi_controller.dart';
import 'package:sdm_handal/model/jam_masuk_model.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';
import 'package:smart_select/smart_select.dart';

class JadwalPegawai extends StatelessWidget {
  const JadwalPegawai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalPegawaiController());
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
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: GFTabs(
            tabBarColor: WAPrimaryColor,
            length: 3,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: <Widget>[
              const Tab(
                icon: Icon(Icons.calendar_today),
                child: Text(
                  "Biasa",
                ),
              ),
              const Tab(
                icon: Icon(Icons.event),
                child: Text(
                  "Tambahan",
                ),
              ),
              const Tab(
                icon: Icon(Icons.book),
                child: Text(
                  "Tukar Dinas",
                ),
              ),
            ],
            tabBarView: GFTabBarView(
              controller: controller.tabController,
              children: <Widget>[
                SingleChildScrollView(
                  child: JadwalBiasa(controller),
                ),
                SingleChildScrollView(
                  child: JadwalTambahan(controller),
                ),
                SingleChildScrollView(
                  child: TukarDinas(controller, context),
                ),
              ],
            ),
            controller: controller.tabController,
          ),
          // SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(
          //       parent: AlwaysScrollableScrollPhysics()),
          //   child: GFSegmentTabs(
          //     tabController: controller.tabController,
          //     length: 2,
          //     width: Get.width,
          //     tabs: <Widget>[
          //       JadwalBiasa(controller),
          //       JadwalBiasa(controller),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  Column JadwalBiasa(JadwalPegawaiController controller) {
    return Column(
      children: [
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jadwal Biasa', style: boldTextStyle(size: 20)),
            Container(
              width: Get.width / 3.5,
              height: 50,
              child: Obx(
                () => DropdownButtonFormField(
                  value: controller.monthSelected,
                  isExpanded: true,
                  decoration: waInputDecoration(
                      bgColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8)),
                  items: controller.months.value.map((Bulan? value) {
                    return DropdownMenuItem<String>(
                      value: value!.bulan,
                      child: Text(value.name!, style: boldTextStyle(size: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.monthSelected = value.toString();
                    controller.getJadwalPegawai();
                  },
                ),
              ),
            ),
          ],
        ).paddingOnly(left: 16, right: 16),
        // 10.height,
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
    );
  }

  Column JadwalTambahan(JadwalPegawaiController controller) {
    return Column(
      children: [
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jadwal Tambahan', style: boldTextStyle(size: 20)),
            Container(
              width: Get.width / 3.5,
              height: 50,
              child: Obx(
                () => DropdownButtonFormField(
                  value: controller.monthSelected,
                  isExpanded: true,
                  decoration: waInputDecoration(
                      bgColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8)),
                  items: controller.months.value.map((Bulan? value) {
                    return DropdownMenuItem<String>(
                      value: value!.bulan,
                      child: Text(value.name!, style: boldTextStyle(size: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.monthSelected = value.toString();
                    controller.getJadwalPegawaiTambahan();
                  },
                ),
              ),
            ),
          ],
        ).paddingOnly(left: 16, right: 16),
        // 10.height,
        ListView.builder(
          shrinkWrap: true,
          itemCount: 31,
          physics: const BouncingScrollPhysics(
            parent: ScrollPhysics(),
          ),
          primary: true,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => JadwalPegawaiTambahan(
                  tanggal: index + 1,
                  jamMasuk: controller.listJamMasuk.value,
                  jadwalPegawai: controller.jadwalPegawaiTambahan.value,
                ).paddingSymmetric(horizontal: 16));
          },
        ),
        20.height,
      ],
    );
  }

  Form TukarDinas(JadwalPegawaiController controller, BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Text('Form Pengajuan Tukar Dinas', style: boldTextStyle(size: 20))
              .paddingLeft(16),
          16.height,
          Text('PJ terkait', style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            width: Get.width,
            decoration: boxDecorationRoundedWithShadow(16),
            child: Obx(
              () => SmartSelect<String>.single(
                title: 'Pilih PJ',
                value: controller.pjSelected.value,
                modalType: S2ModalType.fullPage,
                modalFilter: true,
                modalFilterAuto: true,
                choiceItems: controller.options.value,
                onChange: (state) => controller.pjSelected.value = state.value,
              ),
            ),
          ),
          16.height,
          Text("Tanggal Dinas", style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          AppTextField(
            readOnly: true,
            autoFocus: false,
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime.now().add(const Duration(days: 32)),
                onConfirm: (date) {
                  controller.tanggalDinasController.text =
                      DateFormat('dd-MM-yyyy').format(date);
                  controller.tglMulai.value = date;
                },
                currentTime: controller.tglMulai.value,
                locale: LocaleType.id,
              );
            },
            decoration: waInputDecoration(
                hint: "Masukkan tanggal dinas",
                bgColor: Colors.white,
                borderColor: Colors.grey),
            textFieldType: TextFieldType.NAME,
            keyboardType: TextInputType.name,
            controller: controller.tanggalDinasController,
          ).paddingOnly(left: 16, right: 16, bottom: 16),
          Text("Shift Dinas", style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          SizedBox(
            width: Get.width,
            height: 65,
            child: Obx(
              () => DropdownButtonFormField(
                value: controller.shiftMasuk.value,
                isExpanded: true,
                decoration: waInputDecoration(
                    bgColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8)),
                items:
                    controller.listJamMasuk.value.map((JamMasukModel? value) {
                  return DropdownMenuItem<String>(
                    value: value!.shift,
                    child: Text(
                        value.shift != ''
                            ? '${value.shift} [${value.jamMasuk} - ${value.jamPulang}]'
                            : '-- Pilih Shift --',
                        style: boldTextStyle(size: 14)),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.shiftMasuk.value = value.toString();
                },
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          Text('Pengganti', style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            width: Get.width,
            decoration: boxDecorationRoundedWithShadow(16),
            child: Obx(
              () => SmartSelect<String>.single(
                title: 'Pilih Pengganti',
                value: controller.pengganti.value,
                modalType: S2ModalType.fullPage,
                modalFilter: true,
                modalFilterAuto: true,
                choiceItems: controller.options.value,
                onChange: (state) => controller.pengganti.value = state.value,
              ),
            ),
          ),
          16.height,
          Text("Tanggal Ganti", style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          AppTextField(
            readOnly: true,
            autoFocus: false,
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime.now().add(const Duration(days: 32)),
                onConfirm: (date) {
                  controller.tanggalGantiController.text =
                      DateFormat('dd-MM-yyyy').format(date);
                  controller.tglMulai.value = date;
                },
                currentTime: controller.tglGanti.value,
                locale: LocaleType.id,
              );
            },
            decoration: waInputDecoration(
                hint: "Masukkan tanggal ganti",
                bgColor: Colors.white,
                borderColor: Colors.grey),
            textFieldType: TextFieldType.NAME,
            keyboardType: TextInputType.name,
            controller: controller.tanggalGantiController,
          ).paddingOnly(left: 16, right: 16, bottom: 16),
          Text("Shift Ganti", style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          SizedBox(
            width: Get.width,
            height: 65,
            child: Obx(
              () => DropdownButtonFormField(
                value: controller.shiftGanti.value,
                isExpanded: true,
                decoration: waInputDecoration(
                    bgColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8)),
                items:
                    controller.listJamMasuk.value.map((JamMasukModel? value) {
                  return DropdownMenuItem<String>(
                    value: value!.shift,
                    child: Text(
                        value.shift != ''
                            ? '${value.shift} [${value.jamMasuk} - ${value.jamPulang}]'
                            : '-- Pilih Shift --',
                        style: boldTextStyle(size: 14)),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.shiftGanti.value = value.toString();
                },
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          Text("Kepentingan", style: boldTextStyle(size: 18)).paddingLeft(16),
          8.height,
          AppTextField(
            autoFocus: false,
            maxLines: 3,
            decoration: waInputDecoration(
                hint: "Kepentingan Tukar Dinas", bgColor: white),
            textFieldType: TextFieldType.NAME,
            keyboardType: TextInputType.name,
            controller: controller.kepentinganController,
          ).paddingOnly(left: 16, right: 16),
          16.height,
          AppButton(
                  text: "Ajukan",
                  color: WAPrimaryColor,
                  textColor: Colors.white,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  width: Get.width,
                  onTap: () async {
                    // var res = await c.submitIzin();

                    // CoolAlert.show(
                    //   context: context,
                    //   backgroundColor: WAPrimaryColor,
                    //   confirmBtnColor: WAPrimaryColor,
                    //   type: res!["code"] == 200
                    //       ? CoolAlertType.success
                    //       : CoolAlertType.error,
                    //   text: res['message'],
                    //   onConfirmBtnTap: () =>
                    //       Get.offAllNamed('/dashboard'),
                    // );
                  })
              .paddingOnly(left: 16, right: 16),
          20.height,
        ],
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
          margin: const EdgeInsets.all(20),
          child: DropdownButtonHideUnderline(
            child: GFDropdown(
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(10),
              border: const BorderSide(color: Colors.black12, width: 1),
              dropdownButtonColor: Colors.grey[300],
              onChanged: (newValue) async {
                //print(newValue.toString());
                var sttsCode = await controller.updateJadwalPegawai(
                    tanggal, newValue.toString());
                if (sttsCode == 200) {
                  Get.snackbar(
                    'Notifikasi',
                    'Jadwal berhasil ditambahkan',
                    icon: const Icon(Icons.add_alert_outlined,
                        color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    borderRadius: 20,
                    margin: const EdgeInsets.all(15),
                    duration: const Duration(seconds: 5),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                } else {
                  Get.snackbar(
                    'Notifikasi',
                    'Jadwal gagal ditambahkan error $sttsCode',
                    icon: const Icon(Icons.add_alert_outlined,
                        color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    borderRadius: 20,
                    margin: const EdgeInsets.all(15),
                    duration: const Duration(seconds: 5),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                }
              },
              value: jadwalPegawai?['h${tanggal}'],
              items: jamMasuk
                  ?.map((value) => DropdownMenuItem(
                        value: value.shift,
                        child: Text(
                          value.shift != ''
                              ? '${value.shift} [${value.jamMasuk} - ${value.jamPulang}]'
                              : 'Kosong',
                          style: boldTextStyle(size: 14),
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

class JadwalPegawaiTambahan extends StatelessWidget {
  const JadwalPegawaiTambahan({
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
          margin: const EdgeInsets.all(20),
          child: DropdownButtonHideUnderline(
            child: GFDropdown(
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(10),
              border: const BorderSide(color: Colors.black12, width: 1),
              dropdownButtonColor: Colors.grey[300],
              onChanged: (newValue) async {
                //print(newValue.toString());
                var sttsCode = await controller.updateJadwalTambahan(
                    tanggal, newValue.toString());
                if (sttsCode == 200) {
                  Get.snackbar(
                    'Notifikasi',
                    'Jadwal berhasil ditambahkan',
                    icon: const Icon(Icons.add_alert_outlined,
                        color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    borderRadius: 20,
                    margin: const EdgeInsets.all(15),
                    duration: const Duration(seconds: 5),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                } else {
                  Get.snackbar(
                    'Notifikasi',
                    'Jadwal gagal ditambahkan error $sttsCode',
                    icon: const Icon(Icons.add_alert_outlined,
                        color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    borderRadius: 20,
                    margin: const EdgeInsets.all(15),
                    duration: const Duration(seconds: 5),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                }
              },
              value: jadwalPegawai?['h${tanggal}'],
              items: jamMasuk
                  ?.map((value) => DropdownMenuItem(
                        value: value.shift,
                        child: Text(
                          value.shift != ''
                              ? '${value.shift} [${value.jamMasuk} - ${value.jamPulang}]'
                              : 'Kosong',
                          style: boldTextStyle(size: 14),
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
