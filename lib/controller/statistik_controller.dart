import 'package:get/get.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/jumlah_pasien_model.dart';

class StatistikController extends GetxController {
  var kunjungan = 0.obs;
  var kunjunganTahunIni = 0.obs;
  var perKunjunganTahunIni = 0.obs;
  var kunjunganBulanIni = 0.obs;
  var perKunjunganBulanIni = 0.obs;
  var kunjunganHariIni = 0.obs;
  var perKunjunganHariIni = 0.obs;
  var jmlPasienPoli = <JumlahPasienPoliModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    ttlKunjungan();
    getJmlPasienPoli();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> onRefresh() async {
    ttlKunjungan();
    getJmlPasienPoli();
  }

  Future<void> ttlKunjungan() async {
    try {
      Future.delayed(
        Duration.zero,
      );
      ApiConnection()
          .getData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/statistik')
          .then((res) {
        if (res.statusCode == 200) {
          kunjungan.value = res.body['countVisit'];
          kunjunganTahunIni.value = res.body['countYearVisite'];
          perKunjunganTahunIni.value = int.parse(res.body['perYearVisite']);
          kunjunganBulanIni.value = res.body['countMonthVisite'];
          perKunjunganBulanIni.value =
              int.parse(res.body['perLastMonthVisite']);
          kunjunganHariIni.value = res.body['countCurrentVisite'];
          perKunjunganHariIni.value =
              int.parse(res.body['countLastCurrentVisite']);
        }
      });
    } catch (e) {}
  }

  Future<void> getJmlPasienPoli() async {
    try {
      Future.delayed(
        Duration.zero,
      );
      ApiConnection()
          .getData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jumlahpasienpoli')
          .then((res) => jmlPasienPoli.value =
              jumlahPasienPoliModelFromJson(res.bodyString!));
    } catch (e) {}
  }
}
