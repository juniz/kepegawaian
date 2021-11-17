import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/riwayat_seminar_model.dart';
import 'package:sdm_handal/utils/helper.dart';

class RiwayatSeminarController extends GetxController {
  var idPegawai = "".obs;
  var headerTable = <DataColumn>[].obs;
  var dataTable = <RiwayatSeminarData?>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    idPegawai.value = GetStorage().read('idPegawai');
    headerTable.value = [
      DataColumn(label: Text("Nama Seminar")),
      DataColumn(label: Text("Peran")),
      DataColumn(label: Text("Tanggal")),
      DataColumn(label: Text("Penyelenggara")),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatSeminar();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getRiwayatSeminar() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatseminar',
              body: param)
          .then((res) {
        dataTable.value = riwayatSeminarModelFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
