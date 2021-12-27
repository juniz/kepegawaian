// To parse this JSON data, do
//
//     final jadwalRapatModel = jadwalRapatModelFromJson(jsonString);

import 'dart:convert';

List<JadwalRapatModel> jadwalRapatModelFromJson(String str) =>
    List<JadwalRapatModel>.from(
        json.decode(str).map((x) => JadwalRapatModel.fromJson(x)));

String jadwalRapatModelToJson(List<JadwalRapatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalRapatModel {
  JadwalRapatModel({
    this.id,
    this.agenda,
    this.tanggal,
    this.pimpinan,
    this.petugas,
    this.bahasan,
    this.tanggapan,
    this.stts,
  });

  int? id;
  String? agenda;
  DateTime? tanggal;
  String? pimpinan;
  String? petugas;
  String? bahasan;
  String? tanggapan;
  String? stts;

  factory JadwalRapatModel.fromJson(Map<String, dynamic> json) =>
      JadwalRapatModel(
        id: json["id"],
        agenda: json["agenda"],
        tanggal: DateTime.parse(json["tanggal"]),
        pimpinan: json["pimpinan"],
        petugas: json["petugas"],
        bahasan: json["bahasan"],
        tanggapan: json["tanggapan"],
        stts: json["stts"],
      );

  Map<String, dynamic> toJson() => {
        "agenda": agenda,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "pimpinan": pimpinan,
        "petugas": petugas,
        "bahasan": bahasan,
        "tanggapan": tanggapan,
      };
}
