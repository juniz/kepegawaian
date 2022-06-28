// To parse this JSON data, do
//
//     final absensiTepatWaktu = absensiTepatWaktuFromJson(jsonString);

import 'dart:convert';

List<AbsensiTepatWaktu> absensiTepatWaktuFromJson(String str) =>
    List<AbsensiTepatWaktu>.from(
        json.decode(str).map((x) => AbsensiTepatWaktu.fromJson(x)));

String absensiTepatWaktuToJson(List<AbsensiTepatWaktu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AbsensiTepatWaktu {
  AbsensiTepatWaktu({
    this.nama,
    this.departemen,
    this.photo,
    this.total,
    this.tepatWaktu,
  });

  String? nama;
  String? departemen;
  String? photo;
  int? total;
  int? tepatWaktu;

  factory AbsensiTepatWaktu.fromJson(Map<String, dynamic> json) =>
      AbsensiTepatWaktu(
        nama: json["nama"],
        departemen: json["departemen"],
        photo: json["photo"],
        total: json["total"],
        tepatWaktu: json["tepat_waktu"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "departemen": departemen,
        "photo": photo,
        "total": total,
        "tepat_waktu": tepatWaktu,
      };
}
