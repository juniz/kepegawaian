import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import '../api/api_connection.dart';
import '../model/patroli_model.dart';
import '../screen/barcode_jaga.dart';
import '../utils/helper.dart';

class BarcodeJagaController extends GetxController {
  final provider = Get.put(ApiConnection());
  var id = "".obs;
  var patroli = Patroli().obs;
  var isLoading = true.obs;
  var barcodeScanRes = ''.obs;
  var tgl = DateTime.now().obs;
  late TextEditingController keteranganController;
  late TextEditingController tanggalController;
  @override
  void onInit() {
    keteranganController = TextEditingController();
    tanggalController = TextEditingController();
    tanggalController.text = DateFormat('yyyy-MM-dd').format(tgl.value);
    id.value = GetStorage().read('idPegawai');
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
    var query = {'tanggal': DateFormat('yyyy-MM-dd').format(tgl.value)};
    try {
      Future.delayed(Duration.zero, () {
        provider.patroli(query).then((value) {
          patroli.value = patroliFromJson(value.bodyString!);
        }).onError((error, stackTrace) => null);
      });
      isLoading(false);
    } catch (e) {
      log(e);
      isLoading(false);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tgl.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
      tgl.value = picked;
      loadData();
    }
  }

  Future<void> scanQR() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes.value = '';
      barcodeScanRes.value = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Keluar', true, ScanMode.QR);
      log(barcodeScanRes.value + ' : info');
      if (barcodeScanRes.value != '-1') {
        Get.bottomSheet(const KeteranganWidget());
      }
    } on PlatformException {
      GFToast.showToast(
        'Terjadi kesalahan pada perangkat!',
        Get.overlayContext!,
        toastPosition: GFToastPosition.BOTTOM,
        textStyle: const TextStyle(fontSize: 16, color: GFColors.WHITE),
        backgroundColor: GFColors.DANGER,
        trailing: const Icon(
          Icons.notifications,
          color: GFColors.WHITE,
        ),
      );
    }
  }

  void kirimPatroli() {
    try {
      DialogHelper.showLoading('Loading.....');
      var body = {
        'pegawai': id.value,
        'departement': barcodeScanRes.value,
        'keterangan': keteranganController.text
      };
      provider.kirimPatroli(body).then((value) {
        DialogHelper.hideLoading();
        toasty(
          Get.overlayContext!,
          value.body['message'],
          length: Toast.LENGTH_LONG,
          bgColor:
              value.body['status'] == 'success' ? Colors.green : Colors.red,
          textColor: Colors.white,
          duration: const Duration(seconds: 3),
        );
        keteranganController.clear();
        loadData();
      }).onError((error, stackTrace) {
        DialogHelper.hideLoading();
        toasty(
          Get.overlayContext!,
          error.toString(),
          length: Toast.LENGTH_LONG,
          bgColor: Colors.red,
          textColor: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
    } catch (e) {
      DialogHelper.hideLoading();
      toasty(
        Get.overlayContext!,
        e.toString(),
        length: Toast.LENGTH_LONG,
        bgColor: Colors.red,
        textColor: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
