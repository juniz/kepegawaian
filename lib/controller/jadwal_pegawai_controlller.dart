import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jam_masuk_model.dart';

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

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = new TabController(length: 2, vsync: this);
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
    print(response.bodyString);
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
    print(response.bodyString);
    getJadwalPegawaiTambahan();
    return response.statusCode!;
  }
}
