import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/utils/helper.dart';

class HomeController extends GetxController {
  var nik = "".obs;
  var nama = "".obs;
  var tmpLahir = "".obs;
  var tglLahir = "".obs;
  var alamat = "".obs;
  var photo = "".obs;
  var departemen = "".obs;
  var statusIzin = "".obs;
  var noPengajuanIzin = "".obs;
  var noPengajuanCuti = "".obs;
  var idNotifAdmin = "".obs;
  var version = "".obs;
  var packageName = "".obs;
  var storeVersion = "".obs;
  var storeUrl = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    nama.value = GetStorage().read('nama');
    tmpLahir.value = GetStorage().read('tmp_lahir');
    tglLahir.value = GetStorage().read('tgl_lahir');
    alamat.value = GetStorage().read('alamat');
    photo.value = GetStorage().read('photo');
    noPengajuanIzin.value = GetStorage().read('noPengajuanIzin');
    noPengajuanCuti.value = GetStorage().read('noPengajuanCuti');
    idNotifAdmin.value = GetStorage().read('idNotifAdmin');
    departemen.value = GetStorage().read('cap');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    cekCutiStatus();
    cekIzinStatus();
    cekAdminNotif();
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
        // () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'nik': nik.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/cekizinstatus',
              body: param)
          .then((res) {
        DialogHelper.hideLoading();
        // print('izin status : ${res.body['data']['status']}');
        if (res.body['data']['status'] != 'Proses Persetujuan' &&
            noPengajuanIzin.value != res.body['data']['no_pengajuan']) {
          GetStorage()
              .write('noPengajuanIzin', res.body['data']['no_pengajuan']);
          Get.snackbar(
            'Notifikasi Pengajuan Izin',
            'Pengajuan izin No. ${res.body['data']['no_pengajuan']} ${res.body['data']['status']}',
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: res.body['data']['status'] == 'Disetujui'
                ? Colors.green
                : Colors.red,
            colorText: Colors.white,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
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
        //() => DialogHelper.showLoading('Sedang mengambil data.....'),
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

        if (res.body['data']['status'] != 'Proses Persetujuan' &&
            noPengajuanCuti.value != res.body['data']['no_pengajuan']) {
          GetStorage()
              .write('noPengajuanCuti', res.body['data']['no_pengajuan']);
          Get.snackbar(
            'Notifikasi Pengajuan Izin',
            'Pengajuan Cuti No. ${res.body['data']['no_pengajuan']} ${res.body['data']['status']}',
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: res.body['data']['status'] == 'Disetujui'
                ? Colors.green
                : Colors.red,
            colorText: Colors.white,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }

  Future<void> cekAdminNotif() async {
    try {
      Future.delayed(
        Duration.zero,
        //() => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      // var param = {'nik': nik.value};
      ApiConnection()
          .getData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/cekadminnotif')
          .then((res) {
        DialogHelper.hideLoading();
        //GetStorage().remove('noPengajuanIzin');
        //print(res.bodyString);
        if (idNotifAdmin.value != res.body['id'].toString() &&
            nik.value == res.body['tujuan']) {
          GetStorage().write('idNotifAdmin', res.body['id'].toString());
          Get.snackbar(
            'Permintaan Persetujuan ${res.body['jenis']}',
            res.body['isi'],
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
