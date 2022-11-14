import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/JadwalRapatModel.dart';
import 'package:sdm_handal/utils/helper.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:intl/intl.dart';

class JadwalRapatController extends GetxController {
  final provider = Get.put(ApiConnection());
  var listJadwalRapat = <JadwalRapatModel>[].obs;
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  var image = <int>[].obs;
  var isSigned = false.obs;
  final formKey = GlobalKey<FormState>();
  late TextEditingController rapat;
  late TextEditingController nama;
  late TextEditingController instansi;
  late TextEditingController tanggal;
  var tanggalSelected = DateTime.now().obs;
  var id = "".obs;
  var imageBlob = ''.obs;
  final name = GetStorage().read('nama');
  final nik = GetStorage().read('nik');
  final jbtn = GetStorage().read('jbtn');
  @override
  void onInit() {
    // TODO: implement onInit
    id.value = GetStorage().read('nik');
    rapat = TextEditingController();
    nama = TextEditingController(text: name);
    instansi = TextEditingController(
        text: nik.toString().contains('TKK') ? 'TKK / $jbtn' : '$nik / $jbtn');
    tanggal = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(tanggalSelected.value));
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  clear() {
    tanggalSelected.value = DateTime.now();
    tanggal.text = DateFormat('dd/MM/yyyy').format(tanggalSelected.value);
    rapat.clear();
    nama.clear();
    // image.value.clear();
    isSigned(false);
    imageBlob.value = '';
    instansi.clear();
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  Future<void> handleSaveButtonPressed() async {
    // late Uint8List data;

    final ui.Image imageData =
        await signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await imageData.toByteData(format: ui.ImageByteFormat.png);

    if (bytes != null) {
      var tmp = bytes.buffer.asUint8List();
      imageBlob.value = uint8ListTob64(tmp);
      image.value = bytes.buffer.asUint8List();
      log(imageBlob.value);
      isSigned(true);
      Get.back();
    }
  }

  Future<void> dateWidget(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalSelected.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != tanggalSelected.value) {
      tanggal.text = DateFormat('dd/MM/yyyy').format(picked);
      tanggalSelected.value = picked;
    }
  }

  void kirimRapat() {
    try {
      DialogHelper.showLoading('Loading.....');
      var body = {
        'tanggal': DateFormat('yyyy-MM-dd').format(tanggalSelected.value),
        'rapat': rapat.text,
        'nama': nama.text,
        'instansi': instansi.text,
        'tanda_tangan': imageBlob.value,
      };
      provider.kirimRapat(body).then((value) {
        log(value.bodyString);
        DialogHelper.hideLoading();
        clear();
        toasty(
          Get.overlayContext!,
          value.body['message'],
          length: Toast.LENGTH_LONG,
          bgColor: Colors.green,
          textColor: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }).onError((error, stackTrace) {
        DialogHelper.hideLoading();
        toasty(
          Get.overlayContext!,
          error.toString(),
          length: Toast.LENGTH_LONG,
          bgColor: Colors.red,
          textColor: Colors.white,
          duration: const Duration(seconds: 2),
        );
      });
    } catch (e) {
      DialogHelper.hideLoading();
      toasty(
        Get.overlayContext!,
        e.toString(),
        length: Toast.LENGTH_LONG,
        bgColor: Colors.red,
        textColor: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
