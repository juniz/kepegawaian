import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/controller/cuti_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/model/WalletAppModel.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/WADataGenerator.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';
import 'package:flutter/services.dart';
import 'package:smart_select/smart_select.dart';

class WASendMoneyViaLoopScreen extends StatefulWidget {
  static String tag = '/WASendMoneyViaLoopScreen';

  @override
  WASendMoneyViaLoopScreenState createState() =>
      WASendMoneyViaLoopScreenState();
}

class WASendMoneyViaLoopScreenState extends State<WASendMoneyViaLoopScreen> {
  final c = Get.put(CutiController());

  TextEditingController amountController =
      TextEditingController(text: "\u002450");
  TextEditingController receiptNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  FocusNode receiptNameFocusNode = FocusNode();
  FocusNode accountFocusNode = FocusNode();

  List<WACardModel> sendViaCardList = waSendViaCardList();
  List<JNSCutiModel> jnsCutiCardList = jnsCutiList();
  WACardModel selectedCard = WACardModel();
  JNSCutiModel selectedListCuti = JNSCutiModel();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    selectedCard = sendViaCardList[0];
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Form Pengajuan Cuti',
              style: boldTextStyle(color: Colors.black, size: 20)),
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
                Text("Tanggal Mulai Cuti", style: boldTextStyle(size: 18))
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
                      hint: "Masukkan tanggal mulai cuti",
                      bgColor: Colors.white,
                      borderColor: Colors.grey),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.tanggalMulaiController,
                  focus: c.tanggalMulaiFocusNode,
                  nextFocus: c.tanggalSelesaiFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                Text("Tanggal Selesai Cuti", style: boldTextStyle(size: 18))
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
                      hint: "Masukkan tanggal selesai cuti",
                      bgColor: Colors.white,
                      borderColor: Colors.grey),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.tanggalSelesaiController,
                  focus: c.tanggalSelesaiFocusNode,
                  nextFocus: c.jenisCutiFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                Text("Jenis Cuti", style: boldTextStyle(size: 18))
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
                          items: <String>[
                            'Tahunan',
                            'Sakit',
                            'Istimewa',
                            'Ibadah Keagamaan',
                            'Karena Alasan Penting',
                            'Di luar tanggungan negara',
                            'Tahunan ke luar negeri',
                            'Keterangan lainnya'
                          ].map((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            c.cutiSelected.value = value!;
                          }),
                    ),
                  ),
                ),
                16.height,
                Text("Alamat Tujuan", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  maxLines: 3,
                  decoration: waInputDecoration(
                      hint: "Masukkan alamat tujuan", bgColor: white),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: c.alamatController,
                  focus: c.alamatFocusNode,
                ).paddingOnly(left: 16, right: 16),
                16.height,
                Text("Kepentingan/Alasan Cuti", style: boldTextStyle(size: 18))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  maxLines: 3,
                  decoration: waInputDecoration(
                      hint: "Masukkan alsan cuti", bgColor: white),
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
                          var res = await c.submitCuti();

                          CoolAlert.show(
                            context: context,
                            backgroundColor: WAPrimaryColor,
                            confirmBtnColor: WAPrimaryColor,
                            type: res!['code'] == 200
                                ? CoolAlertType.success
                                : CoolAlertType.error,
                            text: res['message'],
                            onConfirmBtnTap: () =>
                                Get.offAllNamed('/dashboard'),
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
