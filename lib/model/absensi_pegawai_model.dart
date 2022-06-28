// To parse this JSON data, do
//
//     final absensiPegawai = absensiPegawaiFromJson(jsonString);

import 'dart:convert';

List<AbsensiPegawai> absensiPegawaiFromJson(String str) =>
    List<AbsensiPegawai>.from(
        json.decode(str).map((x) => AbsensiPegawai.fromJson(x)));

String absensiPegawaiToJson(List<AbsensiPegawai> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AbsensiPegawai {
  AbsensiPegawai({
    this.nama,
    this.photo,
    this.total,
    this.tepatWaktu,
    this.toleransi,
    this.terlambat1,
    this.terlambat2,
  });

  String? nama;
  String? photo;
  int? total;
  int? tepatWaktu;
  int? toleransi;
  int? terlambat1;
  int? terlambat2;

  factory AbsensiPegawai.fromJson(Map<String, dynamic> json) => AbsensiPegawai(
        nama: json["nama"],
        photo: json["photo"],
        total: json["total"],
        tepatWaktu: json["tepat_waktu"],
        toleransi: json["toleransi"],
        terlambat1: json["terlambat1"],
        terlambat2: json["terlambat2"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "tepat_waktu": tepatWaktu,
        "toleransi": toleransi,
        "terlambat1": terlambat1,
        "terlambat2": terlambat2,
      };
}
