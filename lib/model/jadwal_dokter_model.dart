// To parse this JSON data, do
//
//     final jadwalDokterModel = jadwalDokterModelFromJson(jsonString);

import 'dart:convert';

List<JadwalDokterModel> jadwalDokterModelFromJson(String str) =>
    List<JadwalDokterModel>.from(
        json.decode(str).map((x) => JadwalDokterModel.fromJson(x)));

String jadwalDokterModelToJson(List<JadwalDokterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalDokterModel {
  JadwalDokterModel({
    this.nmPoli,
    this.nmDokter,
    this.jamMulai,
    this.jamSelesai,
  });

  String? nmPoli;
  String? nmDokter;
  String? jamMulai;
  String? jamSelesai;

  factory JadwalDokterModel.fromJson(Map<String, dynamic> json) =>
      JadwalDokterModel(
        nmPoli: json["nm_poli"],
        nmDokter: json["nm_dokter"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
      );

  Map<String, dynamic> toJson() => {
        "nm_poli": nmPoli,
        "nm_dokter": nmDokter,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
      };
}
