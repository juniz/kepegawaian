import 'dart:io';

import 'package:get/get.dart';

class ApiConnection extends GetConnect {
  Future<Response> getData({String? url}) => get(url!);

  Future<Response> postData({String? url, Map<String, dynamic>? body}) =>
      post(url!, body!);

  Future<String> uploadImage(File file) async {
    try {
      final form = FormData({
        'file': MultipartFile(file, filename: 'aa.jpg'),
      });

      final response = await post(
          "https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/uploadphoto",
          form);
      if (response.status.hasError) {
        print(response.bodyString);
        return Future.error(response.body);
      } else {
        return response.body['result'];
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
