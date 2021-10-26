// To parse this JSON data, do
//
//     final pegawaiModel = pegawaiModelFromJson(jsonString);

import 'dart:convert';

PegawaiModel pegawaiModelFromJson(String str) =>
    PegawaiModel.fromJson(json.decode(str));

String pegawaiModelToJson(PegawaiModel data) => json.encode(data.toJson());

class PegawaiModel {
  PegawaiModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<PegawaiData>? data;
  String? message;

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        success: json["success"],
        data: List<PegawaiData>.from(
            json["data"].map((x) => PegawaiData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class PegawaiData {
  PegawaiData({
    this.nik,
    this.nama,
  });

  String? nik;
  String? nama;

  factory PegawaiData.fromJson(Map<String, dynamic> json) => PegawaiData(
        nik: json["nik"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "nama": nama,
      };
}
