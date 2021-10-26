import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/biodata_model.dart';
import 'package:kepegawaian/utils/helper.dart';

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
  var nik = 'TKK0000263';

  @override
  void onInit() {
    // TODO: implement onInit
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

      var param = {'nik': 'TKK0000263'};

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
