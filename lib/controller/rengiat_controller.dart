import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepegawaian/api/api_connection.dart';
import 'package:kepegawaian/model/rengiat_model.dart';

class RengiatController extends GetxController {
  var rengiatData = <RengiatModel>[].obs;
  var dep = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    dep.value = GetStorage().read('cap');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getRengiat();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getRengiat() async {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {'dep': dep.value};
      ApiConnection()
          .postData(
              url:
                  'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/rengiat',
              body: body)
          .then(
            (res) => rengiatData.value = rengiatModelFromJson(res.bodyString!),
          );
    } catch (e) {
      print(e);
    }
  }
}
