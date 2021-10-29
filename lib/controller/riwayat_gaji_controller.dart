import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/riwayat_gaji_model.dart';
import 'package:kepegawaian/utils/helper.dart';

class RiwayatGajiController extends GetxController {
  var idPegawai = ''.obs;
  var headerTable = <DataColumn>[].obs;
  var dataTable = <RiwayatGajiData>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    idPegawai.value = GetStorage().read('idPegawai');
    headerTable.value = [
      const DataColumn(label: Text("No SK")),
      const DataColumn(label: Text("Pangkat Jabatan")),
      const DataColumn(label: Text("Tanggal SK")),
      const DataColumn(label: Text("Gapok")),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatGaji();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getRiwayatGaji() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatgaji',
              body: param)
          .then((res) {
        dataTable.value = riwayatGajiModelFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
