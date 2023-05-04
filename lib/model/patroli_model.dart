// To parse this JSON data, do
//
//     final patroli = patroliFromJson(jsonString);

import 'dart:convert';

Patroli patroliFromJson(String str) => Patroli.fromJson(json.decode(str));

String patroliToJson(Patroli data) => json.encode(data.toJson());

class Patroli {
  Patroli({
    this.data,
    this.status,
    this.message,
  });

  List<Datum>? data;
  String? status;
  String? message;

  factory Patroli.fromJson(Map<String, dynamic> json) => Patroli(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.pegawaiId,
    this.departementId,
    this.tanggal,
    this.jam,
    this.status,
    this.keterangan,
  });

  int? id;
  String? pegawaiId;
  String? departementId;
  DateTime? tanggal;
  String? jam;
  String? status;
  String? keterangan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        pegawaiId: json["pegawai_id"],
        departementId: json["departement_id"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        jam: json["jam"],
        status: json["status"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pegawai_id": pegawaiId,
        "departement_id": departementId,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "jam": jam,
        "status": status,
        "keterangan": keterangan,
      };
}
