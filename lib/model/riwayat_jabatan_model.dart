// To parse this JSON data, do
//
//     final riwayatJabatanModel = riwayatJabatanModelFromJson(jsonString);

import 'dart:convert';

RiwayatJabatanModel riwayatJabatanModelFromJson(String str) =>
    RiwayatJabatanModel.fromJson(json.decode(str));

String riwayatJabatanModelToJson(RiwayatJabatanModel data) =>
    json.encode(data.toJson());

class RiwayatJabatanModel {
  RiwayatJabatanModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatJabatanData>? data;
  String? message;

  factory RiwayatJabatanModel.fromJson(Map<String, dynamic> json) =>
      RiwayatJabatanModel(
        success: json["success"],
        data: List<RiwayatJabatanData>.from(
            json["data"].map((x) => RiwayatJabatanData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatJabatanData {
  RiwayatJabatanData({
    this.id,
    this.jabatan,
    this.tmtPangkat,
    this.tmtPangkatYad,
    this.pejabatPenetap,
    this.nomorSk,
    this.tglSk,
    this.dasarPeraturan,
    this.masaKerja,
    this.blnKerja,
    this.berkas,
  });

  int? id;
  String? jabatan;
  DateTime? tmtPangkat;
  DateTime? tmtPangkatYad;
  String? pejabatPenetap;
  String? nomorSk;
  DateTime? tglSk;
  String? dasarPeraturan;
  int? masaKerja;
  int? blnKerja;
  String? berkas;

  factory RiwayatJabatanData.fromJson(Map<String, dynamic> json) =>
      RiwayatJabatanData(
        id: json["id"],
        jabatan: json["jabatan"],
        tmtPangkat: DateTime.parse(json["tmt_pangkat"]),
        tmtPangkatYad: DateTime.parse(json["tmt_pangkat_yad"]),
        pejabatPenetap: json["pejabat_penetap"],
        nomorSk: json["nomor_sk"],
        tglSk: DateTime.parse(json["tgl_sk"]),
        dasarPeraturan: json["dasar_peraturan"],
        masaKerja: json["masa_kerja"],
        blnKerja: json["bln_kerja"],
        berkas: json["berkas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jabatan": jabatan,
        "tmt_pangkat":
            "${tmtPangkat!.year.toString().padLeft(4, '0')}-${tmtPangkat!.month.toString().padLeft(2, '0')}-${tmtPangkat!.day.toString().padLeft(2, '0')}",
        "tmt_pangkat_yad":
            "${tmtPangkatYad!.year.toString().padLeft(4, '0')}-${tmtPangkatYad!.month.toString().padLeft(2, '0')}-${tmtPangkatYad!.day.toString().padLeft(2, '0')}",
        "pejabat_penetap": pejabatPenetap,
        "nomor_sk": nomorSk,
        "tgl_sk":
            "${tglSk!.year.toString().padLeft(4, '0')}-${tglSk!.month.toString().padLeft(2, '0')}-${tglSk!.day.toString().padLeft(2, '0')}",
        "dasar_peraturan": dasarPeraturan,
        "masa_kerja": masaKerja,
        "bln_kerja": blnKerja,
        "berkas": berkas,
      };
}
