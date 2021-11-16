// To parse this JSON data, do
//
//     final jumlahPasienPoliModel = jumlahPasienPoliModelFromJson(jsonString);

import 'dart:convert';

List<JumlahPasienPoliModel> jumlahPasienPoliModelFromJson(String str) =>
    List<JumlahPasienPoliModel>.from(
        json.decode(str).map((x) => JumlahPasienPoliModel.fromJson(x)));

String jumlahPasienPoliModelToJson(List<JumlahPasienPoliModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JumlahPasienPoliModel {
  JumlahPasienPoliModel({
    this.nmPoli,
    this.jumlah,
  });

  String? nmPoli;
  int? jumlah;

  factory JumlahPasienPoliModel.fromJson(Map<String, dynamic> json) =>
      JumlahPasienPoliModel(
        nmPoli: json["nm_poli"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "nm_poli": nmPoli,
        "jumlah": jumlah,
      };
}
