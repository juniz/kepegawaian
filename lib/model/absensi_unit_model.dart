// To parse this JSON data, do
//
//     final absensiUnit = absensiUnitFromJson(jsonString);

import 'dart:convert';

List<AbsensiUnit> absensiUnitFromJson(String str) => List<AbsensiUnit>.from(
    json.decode(str).map((x) => AbsensiUnit.fromJson(x)));

String absensiUnitToJson(List<AbsensiUnit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AbsensiUnit {
  AbsensiUnit({
    this.depId,
    this.nama,
    this.tepatWaktu,
    this.toleransi,
    this.terlambat1,
    this.terlambat2,
  });

  String? depId;
  String? nama;
  int? tepatWaktu;
  int? toleransi;
  int? terlambat1;
  int? terlambat2;

  factory AbsensiUnit.fromJson(Map<String, dynamic> json) => AbsensiUnit(
        depId: json["dep_id"],
        nama: json["nama"],
        tepatWaktu: json["tepat_waktu"],
        toleransi: json["toleransi"],
        terlambat1: json["terlambat1"],
        terlambat2: json["terlambat2"],
      );

  Map<String, dynamic> toJson() => {
        "dep_id": depId,
        "nama": nama,
        "tepat_waktu": tepatWaktu,
        "toleransi": toleransi,
        "terlambat1": terlambat1,
        "terlambat2": terlambat2,
      };
}
