import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jam_jaga_model.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/helper.dart';
import 'package:location/location.dart';

class PresensiController extends GetxController {
  var listJamJaga = <JamJagaData>[].obs;
  var cap = "".obs;
  var idPegawai = "".obs;
  var shift = "".obs;
  var buttonColor = WAPrimaryColor.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  var lat = "".obs;
  var lng = "".obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 512, maxHeight: 512);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Crop
      // final cropImageFile = await ImageCropper.cropImage(
      //     sourcePath: selectedImagePath.value,
      //     maxWidth: 512,
      //     maxHeight: 512,
      //     compressFormat: ImageCompressFormat.jpg);
      // cropImagePath.value = cropImageFile!.path;
      // cropImageSize.value =
      //     ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
      //             .toStringAsFixed(2) +
      //         " Mb";

      // Compress

      final dir = await Directory.systemTemp;
      final targetPath = dir.absolute.path + "/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          selectedImagePath.value, targetPath,
          quality: 70);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      await uploadImage(compressedFile);
    } else {
      Get.snackbar('Error', 'Gambar tidak ditemukan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    cap.value = GetStorage().read('cap');
    idPegawai.value = GetStorage().read('idPegawai');
    super.onInit();
  }

  @override
  void onReady() {
    //getJamJaga();
    cekPresensi();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<LocationData> determinePosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  void getJamJaga() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var body = {'cap': cap.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/jamjaga',
              body: body)
          .then((res) {
        listJamJaga.value = jamJagaModelFromJson(res.bodyString!).data!;
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }

  void cekPresensi() {
    try {
      Future.delayed(
        Duration.zero,
        //() => DialogHelper.showLoading('Sedang mengambil data.....'),
      );
      var body = {'id': idPegawai.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/cekpresensi',
              body: body)
          .then((res) {
        // print(res.bodyString);
        if (res.statusCode == 200) {
          buttonColor.value = Colors.red;
        } else {
          buttonColor.value = WAPrimaryColor;
        }
        DialogHelper.hideLoading();
      });
    } catch (e) {
      DialogHelper.hideLoading();
    }
  }

  Future<void> uploadImage(File file) async {
    Future.delayed(
      Duration.zero,
      () => DialogHelper.showLoading('Sedang mengambil data.....'),
    );

    var position = await determinePosition();
    final form = FormData({
      'id': idPegawai.value,
      'shift': shift.value,
      'lat': position.latitude,
      'lng': position.longitude,
      'file': MultipartFile(file, filename: 'photo.jpg'),
    });

    ApiConnection()
        .uploadImage(
            url:
                'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/presensi',
            body: form)
        .then((resp) {
      // print(resp.bodyString);
      DialogHelper.hideLoading();
      Get.back();
      if (resp.body['status'] == "success") {
        cekPresensi();
        Get.snackbar(
          'Success',
          resp.body['result'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else if (resp.body['status'] == "error") {
        cekPresensi();
        Get.snackbar(
          'Error',
          resp.body['result'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    }, onError: (err) {
      Get.back();
      Get.snackbar(
        'Error',
        'File upload failed',
        icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    });
  }
}
