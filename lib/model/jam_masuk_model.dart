// To parse this JSON data, do
//
//     final jamMasukModel = jamMasukModelFromJson(jsonString);

import 'dart:convert';

List<JamMasukModel> jamMasukModelFromJson(String str) =>
    List<JamMasukModel>.from(
        json.decode(str).map((x) => JamMasukModel.fromJson(x)));

String jamMasukModelToJson(List<JamMasukModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JamMasukModel {
  JamMasukModel({
    this.shift,
    this.jamMasuk,
    this.jamPulang,
  });

  String? shift;
  String? jamMasuk;
  String? jamPulang;

  factory JamMasukModel.fromJson(Map<String, dynamic> json) => JamMasukModel(
        shift: json["shift"],
        jamMasuk: json["jam_masuk"],
        jamPulang: json["jam_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "shift": shift,
        "jam_masuk": jamMasuk,
        "jam_pulang": jamPulang,
      };
}
