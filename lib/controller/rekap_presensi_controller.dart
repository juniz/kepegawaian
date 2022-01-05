import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/rekap_presensi_model.dart';
import 'package:map_launcher/map_launcher.dart';

class RekapPresensiController extends GetxController {
  var departemen = "".obs;
  var listPresensi = <RekapPresensiData>[].obs;
  var bulan = DateTime.now().month.obs;
  var months = <Bulan>[].obs;
  var monthSelected = DateTime.now().month.obs.toString();
  var lat = "".obs;
  var lng = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    departemen.value = GetStorage().read('cap');
    months.value = [
      Bulan('January', '1'),
      Bulan('February', '2'),
      Bulan('March', '3'),
      Bulan('April', '4'),
      Bulan('May', '5'),
      Bulan('June', '6'),
      Bulan('July', '7'),
      Bulan('August', '8'),
      Bulan('September', '9'),
      Bulan('October', '10'),
      Bulan('November', '11'),
      Bulan('December', '12')
    ];
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRekapPresensi();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getRekapPresensi() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {'departement': departemen.value, 'bulan': monthSelected};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/rekappresensi',
              body: body)
          .then((res) {
        // print(res.bodyString);
        listPresensi.value = rekapPresensiModelFromJson(res.bodyString!).data!;
      });
    } catch (e) {}
  }

  Future<void> getGeo({String? id, String? tanggal}) async {
    var availableMaps = await MapLauncher.installedMaps;
    try {
      Future.delayed(
        Duration.zero,
      );

      var body = {'id': id, 'tanggal': tanggal};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/geolocation',
              body: body)
          .then((res) async {
        // print(body);
        // print(res.bodyString);
        // lat.value = res.body['latitude'];
        // lng.value = res.body['longitude'];

        // print(availableMaps);

        await availableMaps.first.showMarker(
          coords: Coords(
            double.parse(
              res.body['latitude'],
            ),
            double.parse(
              res.body['longitude'],
            ),
          ),
          title: '',
        );
      });
    } catch (e) {}
  }
}

class Bulan {
  String? name;
  String? bulan;
  Bulan(this.name, this.bulan);
}
