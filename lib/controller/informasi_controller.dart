import 'package:get/get.dart';
import 'package:sdm_handal/api/api_connection.dart';
import 'package:sdm_handal/model/carausel_model.dart';
import 'package:sdm_handal/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class InformasiController extends GetxController {
  var listWebContents = <WebContent>[].obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    await getContent();
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

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getContent() async {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang mengambil data.....'),
      );

      await ApiConnection()
          .getData(
              url:
                  'https://rsbhayangkaranganjuk.com/wp-json/wp/v2/posts?per_page=5')
          .then((value) {
        listWebContents.value = webContentFromJson(value.bodyString!);
        DialogHelper.hideLoading();
      });
      //print(data.bodyString);
      // listWebContents.value = webContentFromJson(data.bodyString!);

    } catch (e) {
      // print(e);
      DialogHelper.hideLoading();
    }
  }
}
