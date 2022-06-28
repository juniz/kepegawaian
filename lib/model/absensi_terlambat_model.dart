// To parse this JSON data, do
//
//     final absensiTerlambat = absensiTerlambatFromJson(jsonString);

import 'dart:convert';

List<AbsensiTerlambat> absensiTerlambatFromJson(String str) =>
    List<AbsensiTerlambat>.from(
        json.decode(str).map((x) => AbsensiTerlambat.fromJson(x)));

String absensiTerlambatToJson(List<AbsensiTerlambat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AbsensiTerlambat {
  AbsensiTerlambat({
    this.nama,
    this.departemen,
    this.photo,
    this.total,
    this.totalTerlambat,
    this.terlambat1,
    this.terlambat2,
  });

  String? nama;
  String? departemen;
  String? photo;
  int? total;
  int? totalTerlambat;
  int? terlambat1;
  int? terlambat2;

  factory AbsensiTerlambat.fromJson(Map<String, dynamic> json) =>
      AbsensiTerlambat(
        nama: json["nama"],
        departemen: json["departemen"],
        photo: json["photo"],
        total: json["total"],
        totalTerlambat: json["total_terlambat"],
        terlambat1: json["terlambat1"],
        terlambat2: json["terlambat2"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "departemen": departemen,
        "photo": photo,
        "total": total,
        "total_terlambat": totalTerlambat,
        "terlambat1": terlambat1,
        "terlambat2": terlambat2,
      };
}
