// To parse this JSON data, do
//
//     final riwayatPendidikan = riwayatPendidikanFromJson(jsonString);

import 'dart:convert';

RiwayatPendidikan riwayatPendidikanFromJson(String str) =>
    RiwayatPendidikan.fromJson(json.decode(str));

String riwayatPendidikanToJson(RiwayatPendidikan data) =>
    json.encode(data.toJson());

class RiwayatPendidikan {
  RiwayatPendidikan({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatPendidikanData>? data;
  String? message;

  factory RiwayatPendidikan.fromJson(Map<String, dynamic> json) =>
      RiwayatPendidikan(
        success: json["success"],
        data: List<RiwayatPendidikanData>.from(
            json["data"].map((x) => RiwayatPendidikanData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatPendidikanData {
  RiwayatPendidikanData({
    this.id,
    this.pendidikan,
    this.sekolah,
    this.jurusan,
    this.thnLulus,
    this.kepala,
    this.pendanaan,
    this.keterangan,
    this.status,
    this.berkas,
  });

  int? id;
  String? pendidikan;
  String? sekolah;
  String? jurusan;
  int? thnLulus;
  String? kepala;
  String? pendanaan;
  String? keterangan;
  String? status;
  String? berkas;

  factory RiwayatPendidikanData.fromJson(Map<String, dynamic> json) =>
      RiwayatPendidikanData(
        id: json["id"],
        pendidikan: json["pendidikan"],
        sekolah: json["sekolah"],
        jurusan: json["jurusan"],
        thnLulus: json["thn_lulus"],
        kepala: json["kepala"],
        pendanaan: json["pendanaan"],
        keterangan: json["keterangan"],
        status: json["status"],
        berkas: json["berkas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pendidikan": pendidikan,
        "sekolah": sekolah,
        "jurusan": jurusan,
        "thn_lulus": thnLulus,
        "kepala": kepala,
        "pendanaan": pendanaan,
        "keterangan": keterangan,
        "status": status,
        "berkas": berkas,
      };
}
