import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/riwayat_penghargaan_modal.dart';
import 'package:sdm_handal/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class RiwayatPenghargaanController extends GetxController {
  var idPegawai = "".obs;
  var headerTable = <DataColumn>[].obs;
  var dataTable = <RiwayatPenghargaanData?>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    idPegawai.value = GetStorage().read('idPegawai');
    headerTable.value = [
      DataColumn(
        label: Text("Nama Penghargaan"),
      ),
      DataColumn(
        label: Text("Tanggal"),
      ),
      DataColumn(
        label: Text("Instansi"),
      ),
      DataColumn(
        label: Text("Penjabat Pemberi"),
      ),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatPenghargaan();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> launchURL(String url) async {
    await launch(url);
  }

  getRiwayatPenghargaan() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatpenghargaan',
              body: param)
          .then((res) {
        dataTable.value = riwayatPenghargaanFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
