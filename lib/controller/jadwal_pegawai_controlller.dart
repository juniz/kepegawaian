import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jam_masuk_model.dart';

class JadwalPegawaiController extends GetxController {
  final tahun = "".obs;
  final bulan = <dynamic, dynamic>{}.obs;
  final jmlHari = 0.obs;
  final listJamMasuk = <JamMasukModel>[].obs;
  final jadwalPegawai = <dynamic, dynamic>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    bulan.value = {
      "01": "Januari",
    };
    tahun.value = DateFormat("yyyy").format(DateTime.now());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getJamMasuk();
    getJadwalPegawai();
    super.onReady();
  }

  getJamMasuk() {
    try {
      Future.delayed(
        Duration.zero,
      );
      ApiConnection()
          .getData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jammasuk')
          .then((response) {
        listJamMasuk.value = jamMasukModelFromJson(response.bodyString!);
        listJamMasuk.value.add(JamMasukModel(shift: ''));
      });
    } catch (e) {}
  }

  getJadwalPegawai() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {'id_pegawai': '345', 'bulan': '02', 'tahun': '2022'};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jadwalpegawai',
              body: body)
          .then((response) {
        // print(response.bodyString);
        jadwalPegawai.value = response.body;
      });
    } catch (e) {}
  }

  Future<int> updateJadwalPegawai(int? tanggal, String? shift) async {
    Future.delayed(
      Duration.zero,
    );
    var body = {
      'id_pegawai': '345',
      'bulan': '02',
      'tahun': '2022',
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
}
