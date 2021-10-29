import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/utils/helper.dart';

class HomeController extends GetxController {
  var nik = "".obs;
  var nama = "".obs;
  var statusIzin = "".obs;
  var noPengajuanIzin = "".obs;
  var noPengajuanCuti = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    nama.value = GetStorage().read('nama');
    noPengajuanIzin.value = GetStorage().read('noPengajuanIzin');
    noPengajuanCuti.value = GetStorage().read('noPengajuanCuti');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    cekIzinStatus();

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> cekIzinStatus() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'nik': nik.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/cekizinstatus',
              body: param)
          .then((res) {
        DialogHelper.hideLoading();
        //GetStorage().remove('noPengajuanIzin');
        print(noPengajuanIzin.value);
        if (res.body['data']['status'] == 'Disetujui' &&
            noPengajuanIzin.value != res.body['data']['no_pengajuan']) {
          GetStorage()
              .write('noPengajuanIzin', res.body['data']['no_pengajuan']);
          Get.snackbar(
            'Notifikasi Pengajuan Izin',
            'Pengajuan izin No. ${res.body['data']['no_pengajuan']} ${res.body['data']['status']}',
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }

  Future<void> cekCutiStatus() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'nik': nik.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/cekcutistatus',
              body: param)
          .then((res) {
        DialogHelper.hideLoading();
        //GetStorage().remove('noPengajuanIzin');
        print(noPengajuanCuti.value);
        if (res.body['data']['status'] == 'Disetujui' &&
            noPengajuanCuti.value != res.body['data']['no_pengajuan']) {
          GetStorage()
              .write('noPengajuanCuti', res.body['data']['no_pengajuan']);
          Get.snackbar(
            'Notifikasi Pengajuan Izin',
            'Pengajuan Cuti No. ${res.body['data']['no_pengajuan']} ${res.body['data']['status']}',
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
