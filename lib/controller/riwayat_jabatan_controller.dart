import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/riwayat_jabatan_model.dart';
import 'package:kepegawaian/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class RiwayatJabatanController extends GetxController {
  var idPegawai = "".obs;
  var listRiwayatJabatan = <RiwayatJabatanData>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    idPegawai.value = GetStorage().read('idPegawai');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatJabatan();
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

  Future<void> getRiwayatJabatan() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatjabatan',
              body: param)
          .then((res) {
        listRiwayatJabatan.value =
            riwayatJabatanModelFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
