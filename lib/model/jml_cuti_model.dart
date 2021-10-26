// To parse this JSON data, do
//
//     final jmlCuti = jmlCutiFromJson(jsonString);

import 'dart:convert';

Map<String, int> jmlCutiFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, int>(k, v));

String jmlCutiToJson(Map<String, int> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
