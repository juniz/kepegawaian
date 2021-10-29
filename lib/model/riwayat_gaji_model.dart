// To parse this JSON data, do
//
//     final riwayatGajiModel = riwayatGajiModelFromJson(jsonString);

import 'dart:convert';

RiwayatGajiModel riwayatGajiModelFromJson(String str) =>
    RiwayatGajiModel.fromJson(json.decode(str));

String riwayatGajiModelToJson(RiwayatGajiModel data) =>
    json.encode(data.toJson());

class RiwayatGajiModel {
  RiwayatGajiModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatGajiData>? data;
  String? message;

  factory RiwayatGajiModel.fromJson(Map<String, dynamic> json) =>
      RiwayatGajiModel(
        success: json["success"],
        data: List<RiwayatGajiData>.from(
            json["data"].map((x) => RiwayatGajiData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatGajiData {
  RiwayatGajiData({
    this.id,
    this.pangkatjabatan,
    this.gapok,
    this.tmtBerkala,
    this.tmtBerkalaYad,
    this.noSk,
    this.tglSk,
    this.masaKerja,
    this.bulanKerja,
    this.berkas,
  });

  int? id;
  String? pangkatjabatan;
  int? gapok;
  DateTime? tmtBerkala;
  DateTime? tmtBerkalaYad;
  String? noSk;
  DateTime? tglSk;
  int? masaKerja;
  int? bulanKerja;
  String? berkas;

  factory RiwayatGajiData.fromJson(Map<String, dynamic> json) =>
      RiwayatGajiData(
        id: json["id"],
        pangkatjabatan: json["pangkatjabatan"],
        gapok: json["gapok"],
        tmtBerkala: DateTime.parse(json["tmt_berkala"]),
        tmtBerkalaYad: DateTime.parse(json["tmt_berkala_yad"]),
        noSk: json["no_sk"],
        tglSk: DateTime.parse(json["tgl_sk"]),
        masaKerja: json["masa_kerja"],
        bulanKerja: json["bulan_kerja"],
        berkas: json["berkas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pangkatjabatan": pangkatjabatan,
        "gapok": gapok,
        "tmt_berkala":
            "${tmtBerkala!.year.toString().padLeft(4, '0')}-${tmtBerkala!.month.toString().padLeft(2, '0')}-${tmtBerkala!.day.toString().padLeft(2, '0')}",
        "tmt_berkala_yad":
            "${tmtBerkalaYad!.year.toString().padLeft(4, '0')}-${tmtBerkalaYad!.month.toString().padLeft(2, '0')}-${tmtBerkalaYad!.day.toString().padLeft(2, '0')}",
        "no_sk": noSk,
        "tgl_sk":
            "${tglSk!.year.toString().padLeft(4, '0')}-${tglSk!.month.toString().padLeft(2, '0')}-${tglSk!.day.toString().padLeft(2, '0')}",
        "masa_kerja": masaKerja,
        "bulan_kerja": bulanKerja,
        "berkas": berkas,
      };
}
