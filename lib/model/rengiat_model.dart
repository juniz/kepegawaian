// To parse this JSON data, do
//
//     final rengiatModel = rengiatModelFromJson(jsonString);

import 'dart:convert';

List<RengiatModel> rengiatModelFromJson(String str) => List<RengiatModel>.from(
    json.decode(str).map((x) => RengiatModel.fromJson(x)));

String rengiatModelToJson(List<RengiatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RengiatModel {
  RengiatModel({
    this.noAgenda,
    this.namaGiat,
    this.hasilCapai,
    this.nikPetugas,
  });

  String? noAgenda;
  String? namaGiat;
  String? hasilCapai;
  String? nikPetugas;

  factory RengiatModel.fromJson(Map<String, dynamic> json) => RengiatModel(
        noAgenda: json["no_agenda"],
        namaGiat: json["nama_giat"],
        hasilCapai: json["hasil_capai"],
        nikPetugas: json["nik_petugas"],
      );

  Map<String, dynamic> toJson() => {
        "no_agenda": noAgenda,
        "nama_giat": namaGiat,
        "hasil_capai": hasilCapai,
        "nik_petugas": nikPetugas,
      };
}
