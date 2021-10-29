// To parse this JSON data, do
//
//     final riwayatSeminarModel = riwayatSeminarModelFromJson(jsonString);

import 'dart:convert';

RiwayatSeminarModel riwayatSeminarModelFromJson(String str) =>
    RiwayatSeminarModel.fromJson(json.decode(str));

String riwayatSeminarModelToJson(RiwayatSeminarModel data) =>
    json.encode(data.toJson());

class RiwayatSeminarModel {
  RiwayatSeminarModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RiwayatSeminarData>? data;
  String? message;

  factory RiwayatSeminarModel.fromJson(Map<String, dynamic> json) =>
      RiwayatSeminarModel(
        success: json["success"],
        data: List<RiwayatSeminarData>.from(
            json["data"].map((x) => RiwayatSeminarData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RiwayatSeminarData {
  RiwayatSeminarData({
    this.id,
    this.tingkat,
    this.jenis,
    this.namaSeminar,
    this.peranan,
    this.mulai,
    this.selesai,
    this.penyelengara,
    this.tempat,
    this.berkas,
  });

  int? id;
  Tingkat? tingkat;
  Jenis? jenis;
  String? namaSeminar;
  String? peranan;
  DateTime? mulai;
  DateTime? selesai;
  String? penyelengara;
  Penyelengara? tempat;
  String? berkas;

  factory RiwayatSeminarData.fromJson(Map<String, dynamic> json) =>
      RiwayatSeminarData(
        id: json["id"],
        tingkat: tingkatValues.map![json["tingkat"]],
        jenis: jenisValues.map![json["jenis"]],
        namaSeminar: json["nama_seminar"],
        peranan: json["peranan"],
        mulai: DateTime.parse(json["mulai"]),
        selesai: DateTime.parse(json["selesai"]),
        penyelengara: json["penyelengara"],
        tempat: penyelengaraValues.map![json["tempat"]],
        berkas: json["berkas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tingkat": tingkatValues.reverse![tingkat],
        "jenis": jenisValues.reverse![jenis],
        "nama_seminar": namaSeminar,
        "peranan": perananValues.reverse![peranan],
        "mulai":
            "${mulai!.year.toString().padLeft(4, '0')}-${mulai!.month.toString().padLeft(2, '0')}-${mulai!.day.toString().padLeft(2, '0')}",
        "selesai":
            "${selesai!.year.toString().padLeft(4, '0')}-${selesai!.month.toString().padLeft(2, '0')}-${selesai!.day.toString().padLeft(2, '0')}",
        "penyelengara": penyelengaraValues.reverse![penyelengara],
        "tempat": penyelengaraValues.reverse![tempat],
        "berkas": berkasValues.reverse![berkas],
      };
}

enum Berkas {
  PAGES_RIWAYATSEMINAR_BERKAS_NO_IMAGE_JPG,
  BERKAS_PAGES_RIWAYATSEMINAR_BERKAS_NO_IMAGE_JPG
}

final berkasValues = EnumValues({
  "pages/riwayatseminar/berkas/no-image.jpg":
      Berkas.BERKAS_PAGES_RIWAYATSEMINAR_BERKAS_NO_IMAGE_JPG,
  "pages/riwayatseminar/berkas/No_image.JPG":
      Berkas.PAGES_RIWAYATSEMINAR_BERKAS_NO_IMAGE_JPG
});

enum Jenis { PELATIHAN, SEMINAR }

final jenisValues =
    EnumValues({"PELATIHAN": Jenis.PELATIHAN, "SEMINAR": Jenis.SEMINAR});

enum Penyelengara { RS_BHAYANGKARA_TK_III_NGANJUK, RS_BHAYANGKARA_NGANJUK }

final penyelengaraValues = EnumValues({
  "RS BHAYANGKARA NGANJUK": Penyelengara.RS_BHAYANGKARA_NGANJUK,
  "RS BHAYANGKARA TK.III NGANJUK": Penyelengara.RS_BHAYANGKARA_TK_III_NGANJUK
});

enum Peranan { PESERTA, PANITIA, PELINDUNG }

final perananValues = EnumValues({
  "PANITIA": Peranan.PANITIA,
  "PELINDUNG": Peranan.PELINDUNG,
  "PESERTA": Peranan.PESERTA
});

enum Tingkat { LOCAL }

final tingkatValues = EnumValues({"Local": Tingkat.LOCAL});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
