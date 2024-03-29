import 'dart:io';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/jam_jaga_model.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/helper.dart';

class PresensiController extends GetxController {
  final version = ''.obs;
  final storeVersion = ''.obs;
  final storeUrl = ''.obs;
  final packageName = ''.obs;
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

  var lat = 0.0.obs;
  var lng = 0.0.obs;

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
    //checkVersion();
    super.onInit();
  }

  @override
  void onReady() {
    //getJamJaga();
    cekPresensi();
    getJamJaga();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // var loc = await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getJamJaga() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    try {
      Future.delayed(Duration.zero, () {
        var body = {'cap': cap.value};
        ApiConnection()
            .postData(
                url:
                    'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v2/kepegawaian/jamjaga',
                body: body)
            .then((res) {
          listJamJaga.value = jamJagaModelFromJson(res.bodyString!).data!;
        });
      });
    } catch (e) {}
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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    // var position = await determinePosition();
    final form = FormData({
      'id': idPegawai.value,
      'shift': shift.value,
      'lat': lat.value.toString(),
      'lng': lng.value.toString(),
      'package_name': packageName,
      'build_number': buildNumber,
      'version': version,
      'app_name': appName,
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
          dismissDirection: DismissDirection.horizontal,
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
          dismissDirection: DismissDirection.horizontal,
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
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    });
  }
}
