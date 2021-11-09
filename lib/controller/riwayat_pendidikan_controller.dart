import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/riwayat_pendidikan_model.dart';
import 'package:kepegawaian/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class RiwayatPendidikanController extends GetxController {
  var idPegawai = "".obs;
  var listRiwayatPendidikan = <RiwayatPendidikanData>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    idPegawai.value = GetStorage().read('idPegawai');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatPendidikan();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getRiwayatPendidikan() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var param = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatpendidikan',
              body: param)
          .then((res) {
        listRiwayatPendidikan.value =
            riwayatPendidikanFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
