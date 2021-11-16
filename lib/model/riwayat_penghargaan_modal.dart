// To parse this JSON data, do
//
//     final riwayatPenghargaan = riwayatPenghargaanFromJson(jsonString);

import 'dart:convert';

RiwayatPenghargaan riwayatPenghargaanFromJson(String str) =>
    RiwayatPenghargaan.fromJson(json.decode(str));

String riwayatPenghargaanToJson(RiwayatPenghargaan data) =>
    json.encode(data.toJson());

class RiwayatPenghargaan {
  RiwayatPenghargaan({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatPenghargaanData>? data;
  String? message;

  factory RiwayatPenghargaan.fromJson(Map<String, dynamic> json) =>
      RiwayatPenghargaan(
        success: json["success"],
        data: List<RiwayatPenghargaanData>.from(
            json["data"].map((x) => RiwayatPenghargaanData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatPenghargaanData {
  RiwayatPenghargaanData({
    this.id,
    this.jenis,
    this.namaPenghargaan,
    this.tanggal,
    this.instansi,
    this.pejabatPemberi,
    this.berkas,
  });

  int? id;
  String? jenis;
  String? namaPenghargaan;
  DateTime? tanggal;
  String? instansi;
  String? pejabatPemberi;
  String? berkas;

  factory RiwayatPenghargaanData.fromJson(Map<String, dynamic> json) =>
      RiwayatPenghargaanData(
        id: json["id"],
        jenis: json["jenis"],
        namaPenghargaan: json["nama_penghargaan"],
        tanggal: DateTime.parse(json["tanggal"]),
        instansi: json["instansi"],
        pejabatPemberi: json["pejabat_pemberi"],
        berkas: json["berkas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "nama_penghargaan": namaPenghargaan,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "instansi": instansi,
        "pejabat_pemberi": pejabatPemberi,
        "berkas": berkas,
      };
}
