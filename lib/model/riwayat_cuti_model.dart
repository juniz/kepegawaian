// To parse this JSON data, do
//
//     final riwayatCutiModel = riwayatCutiModelFromJson(jsonString);

import 'dart:convert';

RiwayatCutiModel riwayatCutiModelFromJson(String str) =>
    RiwayatCutiModel.fromJson(json.decode(str));

String riwayatCutiModelToJson(RiwayatCutiModel data) =>
    json.encode(data.toJson());

class RiwayatCutiModel {
  RiwayatCutiModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatCutiDataModel>? data;
  String? message;

  factory RiwayatCutiModel.fromJson(Map<String, dynamic> json) =>
      RiwayatCutiModel(
        success: json["success"],
        data: List<RiwayatCutiDataModel>.from(
            json["data"].map((x) => RiwayatCutiDataModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatCutiDataModel {
  RiwayatCutiDataModel({
    this.noPengajuan,
    this.tanggal,
    this.tanggalAwal,
    this.tanggalAkhir,
    this.nik,
    this.urgensi,
    this.alamat,
    this.jumlah,
    this.kepentingan,
    this.nikPj,
    this.status,
  });

  String? noPengajuan;
  DateTime? tanggal;
  DateTime? tanggalAwal;
  DateTime? tanggalAkhir;
  String? nik;
  String? urgensi;
  String? alamat;
  int? jumlah;
  String? kepentingan;
  String? nikPj;
  String? status;

  factory RiwayatCutiDataModel.fromJson(Map<String, dynamic> json) =>
      RiwayatCutiDataModel(
        noPengajuan: json["no_pengajuan"],
        tanggal: DateTime.parse(json["tanggal"]),
        tanggalAwal: DateTime.parse(json["tanggal_awal"]),
        tanggalAkhir: DateTime.parse(json["tanggal_akhir"]),
        nik: json["nik"],
        urgensi: json["urgensi"],
        alamat: json["alamat"],
        jumlah: json["jumlah"],
        kepentingan: json["kepentingan"],
        nikPj: json["nik_pj"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "no_pengajuan": noPengajuan,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "tanggal_awal":
            "${tanggalAwal!.year.toString().padLeft(4, '0')}-${tanggalAwal!.month.toString().padLeft(2, '0')}-${tanggalAwal!.day.toString().padLeft(2, '0')}",
        "tanggal_akhir":
            "${tanggalAkhir!.year.toString().padLeft(4, '0')}-${tanggalAkhir!.month.toString().padLeft(2, '0')}-${tanggalAkhir!.day.toString().padLeft(2, '0')}",
        "nik": nik,
        "urgensi": urgensi,
        "alamat": alamat,
        "jumlah": jumlah,
        "kepentingan": kepentingan,
        "nik_pj": nikPj,
        "status": status,
      };
}
