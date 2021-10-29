// To parse this JSON data, do
//
//     final jamJagaModel = jamJagaModelFromJson(jsonString);

import 'dart:convert';

JamJagaModel jamJagaModelFromJson(String str) =>
    JamJagaModel.fromJson(json.decode(str));

String jamJagaModelToJson(JamJagaModel data) => json.encode(data.toJson());

class JamJagaModel {
  JamJagaModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<JamJagaData>? data;
  String? message;

  factory JamJagaModel.fromJson(Map<String, dynamic> json) => JamJagaModel(
        success: json["success"],
        data: List<JamJagaData>.from(
            json["data"].map((x) => JamJagaData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class JamJagaData {
  JamJagaData({
    this.noId,
    this.depId,
    this.shift,
    this.jamMasuk,
    this.jamPulang,
  });

  int? noId;
  String? depId;
  String? shift;
  String? jamMasuk;
  String? jamPulang;

  factory JamJagaData.fromJson(Map<String, dynamic> json) => JamJagaData(
        noId: json["no_id"],
        depId: json["dep_id"],
        shift: json["shift"],
        jamMasuk: json["jam_masuk"],
        jamPulang: json["jam_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "no_id": noId,
        "dep_id": depId,
        "shift": shift,
        "jam_masuk": jamMasuk,
        "jam_pulang": jamPulang,
      };
}
