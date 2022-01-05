import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/helper.dart';

class LoginController extends GetxController {
  var context = Get.context;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passWordFocusNode;

  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passWordFocusNode = FocusNode();
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

  Future<void> login() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );

      var param = {
        'username': emailController.text,
        'password': passwordController.text,
      };
      // print(param);
      // var response = await Dio().post(
      //     'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/kepegawaian/login',
      //     data: param);
      var response = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/kepegawaian/login',
          body: param);
      if (response.statusCode == 200) {
        var body = response.body;

        GetStorage().write('idPegawai', body['data']['id'].toString());
        GetStorage().write('nik', body['data']['username']);
        GetStorage().write('password', body['data']['password']);
        GetStorage().write('nama', body['data']['nama']);
        GetStorage().write('cap', body['data']['cap']);
        DateTime parseDate =
            DateFormat("yyyy-MM-dd").parse(body['data']['tgl_lahir']);
        var tglLahir = DateFormat("dd-MM-yyyy").format(parseDate);
        GetStorage().write('tmp_lahir', body['data']['tmp_lahir']);
        GetStorage().write('tgl_lahir', tglLahir);
        GetStorage().write('alamat', body['data']['alamat']);
        GetStorage().write('photo', body['data']['photo']);
        DialogHelper.hideLoading();
        Get.offAllNamed('/dashboard');
      } else if (response.statusCode == 404) {
        // print(response.statusCode);
        DialogHelper.hideLoading();
        CoolAlert.show(
          context: context!,
          backgroundColor: WAPrimaryColor,
          confirmBtnColor: WAPrimaryColor,
          type: CoolAlertType.error,
          title: 'Username atau Password salah',
        );
      } else {
        print(response.statusText);
        DialogHelper.hideLoading();
        CoolAlert.show(
          context: context!,
          backgroundColor: WAPrimaryColor,
          confirmBtnColor: WAPrimaryColor,
          type: CoolAlertType.error,
          title: response.statusText,
        );
      }
    } catch (e) {
      DialogHelper.hideLoading();
      CoolAlert.show(
        context: context!,
        backgroundColor: WAPrimaryColor,
        confirmBtnColor: WAPrimaryColor,
        type: CoolAlertType.error,
        title: e.toString(),
      );
      DialogHelper.hideLoading();
    }
  }
}
