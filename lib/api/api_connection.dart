import 'package:get/get.dart';
import 'package:sdm_handal/utils/WAUrl.dart';

class ApiConnection extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = urlBase;
    httpClient.timeout = const Duration(minutes: 1);
  }

  Future<Response> login(Map data) async {
    final response = await post(urlLogin, data);
    if (response.isOk) {
      return response;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<Response> cekIzinStatus(Map data) async {
    final response = await post(urlCekIzinStatus, data);
    if (response.isOk) {
      return response;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<Response> cekCutiStatus(Map data) async {
    final response = await post(urlCekCutiStatus, data);
    if (response.isOk) {
      return response;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<Response> absensiUnit(Map data) async {
    try {
      final response = await post(urlAbsensiUnit, data);
      if (response.isOk) {
        return response;
      } else {
        return Future.error(response.statusText!);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> absensiPegawai(Map data) async {
    try {
      final response = await post(urlAbsensiPegawai, data);
      if (response.isOk) {
        return response;
      } else {
        return Future.error(response.statusText!);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getData({String? url}) => get(url!);

  Future<Response> postData({String? url, Map<String, dynamic>? body}) =>
      post(url!, body!);

  Future<Response> uploadImage({String? url, FormData? body}) =>
      post(url, body);
}
