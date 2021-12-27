import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/JadwalRapatModel.dart';
import 'package:sdm_handal/utils/helper.dart';

class JadwalRapatController extends GetxController {
  var listJadwalRapat = <JadwalRapatModel>[].obs;
  var id = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    id.value = GetStorage().read('idPegawai');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getJadwalRapat();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getJadwalRapat() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'id_peserta': id.value,
      };
      ApiConnection()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jadwalrapat',
              body)
          .then((res) {
        listJadwalRapat.value = jadwalRapatModelFromJson(res.bodyString!);
      });
    } catch (e) {}
  }

  hadirRapat(String idRapat) {
    try {
      Future.delayed(Duration.zero, DialogHelper.showLoading('Loading.....'));
      var body = {
        'id_peserta': id.value,
        'id_rapat': idRapat,
      };
      ApiConnection()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/hadirrapat',
              body)
          .then((res) {
        DialogHelper.hideLoading();
        var code = res.statusCode;
        Get.snackbar(
          code == 200 ? 'Success' : 'Gagal',
          res.body['message'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: code == 200 ? Colors.green : Colors.red,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        getJadwalRapat();
      });
    } catch (e) {}
  }
}
