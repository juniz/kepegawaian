import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../api/api_connection.dart';
import '../model/helpdesk_model.dart';

class HelpdeskController extends GetxController {
  final provider = Get.put(ApiConnection());
  final formKey = GlobalKey<FormState>();
  late TextEditingController permintaanController;
  late TextEditingController langkahController;
  var helpdeskRes = Helpdesk().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    permintaanController = TextEditingController();
    langkahController = TextEditingController();
    loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> loadData() async {
    var query = {
      'departemen': GetStorage().read('cap'),
    };
    try {
      Future.delayed(Duration.zero, () {
        provider.helpdesk(query).then((value) {
          helpdeskRes.value = helpdeskFromJson(value.bodyString!);
        }).onError((error, stackTrace) => null);
      });
      isLoading(false);
    } catch (e) {
      log(e);
      isLoading(false);
    }
  }

  Future<void> simpanData() async {
    var body = {
      'pegawai_id': GetStorage().read('idPegawai'),
      'unit': GetStorage().read('cap'),
      'permintaan': permintaanController.text,
      'langkah_dilakukan': langkahController.text,
    };
    try {
      Future.delayed(Duration.zero, () async {});
      var response = await provider.simpanHelpdesk(body);
      Get.back();
      loadData();
      toasty(
        Get.overlayContext!,
        response.body['message'],
        length: Toast.LENGTH_LONG,
        bgColor: response.body['error'] ? Colors.red : Colors.green,
        textColor: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      log(e);
      Get.back();
      toasty(
        Get.overlayContext!,
        e.toString(),
        length: Toast.LENGTH_LONG,
        bgColor: Colors.red,
        textColor: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
