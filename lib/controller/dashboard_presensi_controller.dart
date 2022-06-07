import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/absensi_unit_model.dart';

class DashboardPresensiController extends GetConnect {
  final provider = Get.put(ApiConnection());
  final listAbsensiUnit = <AbsensiUnit>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getAbsensiUnit();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getAbsensiUnit() async {
    var data = {'tanggal': '2022-05-'};
    Future.delayed(
      Duration.zero,
      () => provider.absensiUnit(data).then(
            (value) =>
                listAbsensiUnit.value = absensiUnitFromJson(value.bodyString!),
          ),
    );
  }
}
