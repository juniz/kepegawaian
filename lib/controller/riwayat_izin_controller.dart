import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/riwayat_cuti_model.dart';
import 'package:kepegawaian/utils/helper.dart';

class RiwayatIzinController extends GetxController {
  var nik = "".obs;
  var listRiwayatCuti = <RiwayatCutiDataModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRiwayatIzin();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getRiwayatIzin() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );

      var param = {'nik': nik.value};

      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/riwayatizin',
              body: param)
          .then((res) {
        listRiwayatCuti.value = riwayatCutiModelFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }
}
