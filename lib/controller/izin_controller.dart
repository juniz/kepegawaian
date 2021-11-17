import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/pegawai_model.dart';
import 'package:sdm_handal/utils/helper.dart';
import 'package:smart_select/smart_select.dart';

class IzinController extends GetxController {
  var listPegawai = <PegawaiData?>[].obs;
  var options = [
    S2Choice<String>(value: '', title: ''),
  ].obs;
  var pjSelected = ''.obs;
  var tglMulai = DateTime.now().obs;
  var tglSelesai = DateTime.now().obs;
  var cutiSelected = ''.obs;
  var nik = "".obs;
  late TextEditingController tanggalMulaiController;
  late TextEditingController tanggalSelesaiController;
  late TextEditingController alamatController;
  late TextEditingController alasanController;

  late FocusNode tanggalMulaiFocusNode;
  late FocusNode tanggalSelesaiFocusNode;
  late FocusNode pjFocusNode;
  late FocusNode jenisCutiFocusNode;
  late FocusNode alamatFocusNode;
  late FocusNode alasanFocusNode;

  @override
  void onInit() async {
    cutiSelected.value = 'Perjalanan Dinas';
    tanggalMulaiController = TextEditingController();
    tanggalSelesaiController = TextEditingController();
    alamatController = TextEditingController();
    alasanController = TextEditingController();

    tanggalMulaiFocusNode = FocusNode();
    tanggalSelesaiFocusNode = FocusNode();
    pjFocusNode = FocusNode();
    jenisCutiFocusNode = FocusNode();
    alamatFocusNode = FocusNode();
    alasanFocusNode = FocusNode();

    nik.value = GetStorage().read('nik');

    await getPegawai();
    super.onInit();
  }

  Future<PegawaiModel?> getPegawai() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );

      var data = await ApiConnection().getData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/pegawai');
      listPegawai.value = pegawaiModelFromJson(data.bodyString!).data!;
      print(data.bodyString);
      options.value = listPegawai.value
          .map((e) => S2Choice<String>(value: e!.nik, title: e.nama))
          .toList();
      DialogHelper.hideLoading();
    } on Exception catch (e) {
      printError(info: e.toString());
      DialogHelper.hideLoading();
    }
  }

  Future<Map<String, dynamic>?> submitIzin() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengirim data.....'),
      );

      var param = {
        'tanggal_awal': DateFormat('yyyy-MM-dd').format(tglMulai.value),
        'tanggal_akhir': DateFormat('yyyy-MM-dd').format(tglSelesai.value),
        'nik': nik.value,
        'urgensi': cutiSelected.value,
        'kepentingan': alasanController.text,
        'nik_pj': pjSelected.value,
      };

      var data = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/izin',
          body: param);
      print(data.bodyString);
      var response = data.body;
      if (data.statusCode == 200) {
        // GetStorage().write('noPengajuanIzin', response['data']['no_pengajuan']);
      }
      DialogHelper.hideLoading();
      return {'code': data.statusCode, 'message': response['message']};
    } on Exception catch (e) {
      printError(info: e.toString());
      DialogHelper.hideLoading();
      return {'code': 500, 'message': 'Tidak terhubung server'};
    }
  }
}
