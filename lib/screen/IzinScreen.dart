import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/controller/cuti_controller.dart';
import 'package:kepegawaian/controller/izin_controller.dart';
import 'package:kepegawaian/screen/WAHomeScreen.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_select/smart_select.dart';

class IzinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(IzinController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Form Pengajuan Izin',
              style: boldTextStyle(color: Colors.black, size: 20)),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(Icons.arrow_back),
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
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/walletApp/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text('PJ', style: boldTextStyle(size: 18)).paddingLeft(16),
                8.height,
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: Get.width,
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Obx(
                    () => SmartSelect<String>.single(
                      title: 'Pilih PJ',
                      value: c.pjSelected.value,
                      modalType: S2ModalType.fullPage,
                      modalFilter: true,
                      modalFilterAuto: true,
                      choiceItems: c.options.value,
                      onChange: (state) => c.pjSelected.value = state.value,
                    ),
                  ),
                ),
                16.height,
                Text("Tanggal Mulai Izin", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
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
                        c.tanggalMulaiController.text =
                            DateFormat('dd-MM-yyyy').format(date);
                        c.tglMulai.value = date;
                      },
                      currentTime: c.tglMulai.value,
                      locale: LocaleType.id,
                    );
                  },
                  decoration: waInputDecoration(
                      hint: "Masukkan tanggal mulai izin",
                      bgColor: Colors.white,
                      borderColor: Colors.grey),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.tanggalMulaiController,
                  focus: c.tanggalMulaiFocusNode,
                  nextFocus: c.tanggalSelesaiFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                Text("Tanggal Selesai Izin", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
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
                        c.tanggalSelesaiController.text =
                            DateFormat('dd-MM-yyyy').format(date);
                        c.tglSelesai.value = date;
                      },
                      currentTime: c.tglSelesai.value,
                      locale: LocaleType.id,
                    );
                  },
                  decoration: waInputDecoration(
                      hint: "Masukkan tanggal selesai izin",
                      bgColor: Colors.white,
                      borderColor: Colors.grey),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.tanggalSelesaiController,
                  focus: c.tanggalSelesaiFocusNode,
                  nextFocus: c.jenisCutiFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                Text("Jenis Izin", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: Get.width,
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      () => DropdownButton<String>(
                          focusNode: c.jenisCutiFocusNode,
                          value: c.cutiSelected.value,
                          items: <String>['Perjalanan Dinas', 'Lain-lain']
                              .map((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            c.cutiSelected.value = value!;
                            print(c.cutiSelected.value);
                          }),
                    ),
                  ),
                ),
                16.height,
                // Text("Alamat Tujuan", style: boldTextStyle(size: 18))
                //     .paddingLeft(16),
                // 16.height,
                // AppTextField(
                //   autoFocus: false,
                //   maxLines: 3,
                //   decoration: waInputDecoration(
                //       hint: "Masukkan alamat tujuan", bgColor: white),
                //   textFieldType: TextFieldType.NAME,
                //   keyboardType: TextInputType.name,
                //   controller: c.alamatController,
                //   focus: c.alamatFocusNode,
                // ).paddingOnly(left: 16, right: 16),
                // 16.height,
                Text("Kepentingan/Alasan Izin", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  maxLines: 3,
                  decoration: waInputDecoration(
                      hint: "Masukkan alsan izin", bgColor: white),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.alasanController,
                  focus: c.alasanFocusNode,
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
                          var res = await c.submitIzin();

                          CoolAlert.show(
                            context: context,
                            backgroundColor: WAPrimaryColor,
                            confirmBtnColor: WAPrimaryColor,
                            type: res!["code"] == 200
                                ? CoolAlertType.success
                                : CoolAlertType.error,
                            text: res['message'],
                            onConfirmBtnTap: () => Get.off(WAHomeScreen()),
                          );
                        })
                    .paddingOnly(left: Get.width * 0.1, right: Get.width * 0.1),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
