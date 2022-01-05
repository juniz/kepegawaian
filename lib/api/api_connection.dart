import 'dart:io';

import 'package:get/get.dart';

class ApiConnection extends GetConnect {
  @override
  void onInit() {}
  Future<Response> getData({String? url}) => get(url!);

  Future<Response> postData({String? url, Map<String, dynamic>? body}) =>
      post(url!, body!);

  Future<Response> uploadImage({String? url, FormData? body}) =>
      post(url, body);
}
