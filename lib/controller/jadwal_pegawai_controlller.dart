import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jam_masuk_model.dart';
import 'package:smart_select/smart_select.dart';

import '../model/pegawai_model.dart';
import '../utils/helper.dart';
import 'rekap_presensi_controller.dart';

class JadwalPegawaiController extends GetxController
    with SingleGetTickerProviderMixin {
  final cap = "".obs;
  final idPegawai = "".obs;
  final tahun = "".obs;
  var months = <Bulan>[].obs;
  final jmlHari = 0.obs;
  final listJamMasuk = <JamMasukModel>[].obs;
  final jadwalPegawai = <dynamic, dynamic>{}.obs;
  final jadwalPegawaiTambahan = <dynamic, dynamic>{}.obs;
  var monthSelected = DateTime.now().month.obs.toString();
  late TabController tabController;
  var options = [
    S2Choice<String>(value: '', title: ''),
  ].obs;
  var pjSelected = ''.obs;
  var pengganti = ''.obs;
  var tglMulai = DateTime.now().obs;
  var tglGanti = DateTime.now().obs;
  var listPegawai = <PegawaiData?>[].obs;
  late TextEditingController tanggalDinasController;
  late TextEditingController tanggalGantiController;
  late TextEditingController kepentinganController;
  final shiftMasuk = "".obs;
  final shiftGanti = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    tabController = TabController(length: 3, vsync: this);
    cap.value = GetStorage().read('cap');
    idPegawai.value = GetStorage().read('idPegawai');
    months.value = [
      Bulan('January', '1'),
      Bulan('February', '2'),
      Bulan('March', '3'),
      Bulan('April', '4'),
      Bulan('May', '5'),
      Bulan('June', '6'),
      Bulan('July', '7'),
      Bulan('August', '8'),
      Bulan('September', '9'),
      Bulan('October', '10'),
      Bulan('November', '11'),
      Bulan('December', '12')
    ];
    tahun.value = DateFormat("yyyy").format(DateTime.now());

    tanggalDinasController = TextEditingController();
    tanggalGantiController = TextEditingController();
    kepentinganController = TextEditingController();
    await getPegawai();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getJamMasuk();
    getJadwalPegawai();
    getJadwalPegawaiTambahan();
    //print(idPegawai.value);
    super.onReady();
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

  getJamMasuk() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {'cap': cap.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jammasuk',
              body: body)
          .then((response) {
        //print(response.bodyString);
        listJamMasuk.value = jamMasukModelFromJson(response.bodyString!);
        listJamMasuk.value.add(JamMasukModel(shift: '', jamMasuk: '-'));
      });
    } catch (e) {}
  }

  getJadwalPegawai() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'id_pegawai': idPegawai.value,
        'bulan': monthSelected.padLeft(2, '0'),
        'tahun': DateTime.now().year.toString()
      };
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jadwalpegawai',
              body: body)
          .then((response) {
        // print(body);
        // print(response.bodyString);
        jadwalPegawai.value = response.body;
      });
    } catch (e) {}
  }

  getJadwalPegawaiTambahan() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'id_pegawai': idPegawai.value,
        'bulan': monthSelected.padLeft(2, '0'),
        'tahun': DateTime.now().year.toString()
      };
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jadwalpegawaitambahan',
              body: body)
          .then((response) {
        // print(body);
        // print(response.bodyString);
        jadwalPegawaiTambahan.value = response.body;
      });
    } catch (e) {}
  }

  Future<int> updateJadwalPegawai(int? tanggal, String? shift) async {
    Future.delayed(
      Duration.zero,
    );
    var body = {
      'id_pegawai': idPegawai.value,
      'bulan': monthSelected.padLeft(2, '0'),
      'tahun': DateTime.now().year.toString(),
      'tanggal': tanggal,
      'shift': shift,
      'hari': 'h$tanggal',
    };
    final response = await ApiConnection().postData(
        url:
            'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/updatejadwal',
        body: body);
    // print(response.bodyString);
    getJadwalPegawai();
    return response.statusCode!;
  }

  Future<int> updateJadwalTambahan(int? tanggal, String? shift) async {
    Future.delayed(
      Duration.zero,
    );
    var body = {
      'id_pegawai': idPegawai.value,
      'bulan': monthSelected.padLeft(2, '0'),
      'tahun': DateTime.now().year.toString(),
      'tanggal': tanggal,
      'shift': shift,
      'hari': 'h$tanggal',
    };
    final response = await ApiConnection().postData(
        url:
            'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/updatejadwaltambahan',
        body: body);
    // print(response.bodyString);
    getJadwalPegawaiTambahan();
    return response.statusCode!;
  }
}
