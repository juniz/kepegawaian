// To parse this JSON data, do
//
//     final helpdesk = helpdeskFromJson(jsonString);

import 'dart:convert';

Helpdesk helpdeskFromJson(String str) => Helpdesk.fromJson(json.decode(str));

String helpdeskToJson(Helpdesk data) => json.encode(data.toJson());

class Helpdesk {
  bool? error;
  String? message;
  List<Datum>? data;

  Helpdesk({
    this.error,
    this.message,
    this.data,
  });

  factory Helpdesk.fromJson(Map<String, dynamic> json) => Helpdesk(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  int? pegawaiId;
  DateTime? tanggal;
  String? unit;
  String? permintaan;
  String? langkahDilakukan;
  String? status;
  String? nama;

  Datum({
    this.id,
    this.pegawaiId,
    this.tanggal,
    this.unit,
    this.permintaan,
    this.langkahDilakukan,
    this.status,
    this.nama,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        pegawaiId: json["pegawai_id"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        unit: json["unit"],
        permintaan: json["permintaan"],
        langkahDilakukan: json["langkah_dilakukan"],
        status: json["status"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pegawai_id": pegawaiId,
        "tanggal": tanggal?.toIso8601String(),
        "unit": unit,
        "permintaan": permintaan,
        "langkah_dilakukan": langkahDilakukan,
        "status": status,
        "nama": nama,
      };
}
