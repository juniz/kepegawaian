import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/biodata_model.dart';
import 'package:sdm_handal/utils/helper.dart';

class ProfileController extends GetxController {
  var dataBiodata = DataBiodata(
          id: 0,
          nik: '',
          nama: '',
          jk: '',
          jbtn: '',
          jnjJabatan: '',
          kodeKelompok: '',
          kodeResiko: '',
          kodeEmergency: '',
          departemen: '',
          bidang: '',
          sttsWp: '',
          sttsKerja: '',
          npwp: '',
          pendidikan: '',
          gapok: 0,
          tmpLahir: '',
          tglLahir: DateTime.now(),
          alamat: '',
          kota: '',
          mulaiKerja: DateTime.now(),
          msKerja: '',
          indexins: '',
          bpd: '',
          rekening: '',
          sttsAktif: '',
          wajibmasuk: 0,
          pengurang: 0,
          indek: 0,
          mulaiKontrak: DateTime.now(),
          cutiDiambil: 0,
          dankes: 0,
          photo: '',
          noKtp: '',
          email: '')
      .obs;
  var nik = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nik.value = GetStorage().read('nik');
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady

    await getBiodata();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<Map<String, dynamic>?> getBiodata() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );

      var param = {'nik': nik.value};

      var data = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/biodata',
          body: param);

      var response = data.body;
      dataBiodata.value = biodataModelFromJson(data.bodyString).data;
      DialogHelper.hideLoading();
      return {'code': data.statusCode, 'message': response['message']};
    } on Exception catch (e) {
      printError(info: e.toString());
      DialogHelper.hideLoading();
    }
  }
}
