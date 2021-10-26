import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/helper.dart';

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
      var res = await ApiConnection().postData(
          url:
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/kepegawaian/login',
          body: param);
      if (res.statusCode == 200) {
        var body = res.body;
        print(body['data']['nama']);
        GetStorage().write('nik', body['data']['username']);
        GetStorage().write('nama', body['data']['nama']);
        DialogHelper.hideLoading();
        Get.toNamed('/dashboard');
      } else {
        DialogHelper.hideLoading();
        CoolAlert.show(
          context: context!,
          backgroundColor: WAPrimaryColor,
          confirmBtnColor: WAPrimaryColor,
          type: CoolAlertType.error,
          title: 'Username atau Password salah',
        );
      }
    } catch (e) {}
  }
}
