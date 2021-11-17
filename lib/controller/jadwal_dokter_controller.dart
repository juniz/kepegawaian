import 'package:get/get.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jadwal_dokter_model.dart';

class JadwalDokterController extends GetxController {
  var listJadwalController = <JadwalDokterModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getJadwalDokter();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getJadwalDokter() {
    try {
      Future.delayed(
        Duration.zero,
      );
      ApiConnection()
          .getData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jadwaldokter')
          .then((res) {
        listJadwalController.value = jadwalDokterModelFromJson(res.bodyString!);
      });
    } catch (e) {}
  }
}
