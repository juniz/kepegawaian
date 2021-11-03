// To parse this JSON data, do
//
//     final rekapPresensiModel = rekapPresensiModelFromJson(jsonString);

import 'dart:convert';

RekapPresensiModel rekapPresensiModelFromJson(String str) =>
    RekapPresensiModel.fromJson(json.decode(str));

String rekapPresensiModelToJson(RekapPresensiModel data) =>
    json.encode(data.toJson());

class RekapPresensiModel {
  RekapPresensiModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<RekapPresensiData>? data;
  String? message;

  factory RekapPresensiModel.fromJson(Map<String, dynamic> json) =>
      RekapPresensiModel(
        success: json["success"],
        data: List<RekapPresensiData>.from(
            json["data"].map((x) => RekapPresensiData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RekapPresensiData {
  RekapPresensiData(
      {this.nama,
      this.departemen,
      this.id,
      this.shift,
      this.jamDatang,
      this.jamPulang,
      this.status,
      this.durasi,
      this.photo,
      this.latitude,
      this.longitude});

  String? nama;
  String? departemen;
  int? id;
  String? shift;
  DateTime? jamDatang;
  DateTime? jamPulang;
  String? status;
  String? durasi;
  String? photo;
  String? latitude;
  String? longitude;

  factory RekapPresensiData.fromJson(Map<String, dynamic> json) =>
      RekapPresensiData(
        nama: json["nama"],
        departemen: json["departemen"],
        id: json["id"],
        shift: json["shift"],
        jamDatang: DateTime.parse(json["jam_datang"]),
        jamPulang: DateTime.parse(json["jam_pulang"]),
        status: json["status"],
        durasi: json["durasi"],
        photo: json["photo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "nama": namaValues.reverse![nama],
        "departemen": departemenValues.reverse![departemen],
        "id": id,
        "shift": shiftValues.reverse![shift],
        "jam_datang": jamDatang!.toIso8601String(),
        "jam_pulang": jamPulang!.toIso8601String(),
        "status": statusValues.reverse![status],
        "durasi": durasi,
        "photo": photo,
      };
}

enum Departemen { IT }

final departemenValues = EnumValues({"IT": Departemen.IT});

enum Nama { ADI_SETYAWAN, YUDO_JUNI_HARDIKO, HARIES_ROCHMATULLAH_S_KOM }

final namaValues = EnumValues({
  "ADI SETYAWAN": Nama.ADI_SETYAWAN,
  "HARIES ROCHMATULLAH, S. Kom": Nama.HARIES_ROCHMATULLAH_S_KOM,
  "YUDO JUNI HARDIKO": Nama.YUDO_JUNI_HARDIKO
});

enum Shift { PAGI4, PAGI3 }

final shiftValues = EnumValues({"Pagi3": Shift.PAGI3, "Pagi4": Shift.PAGI4});

enum Status { TEPAT_WAKTU, TERLAMBAT_TOLERANSI, TERLAMBAT_TOLERANSI_PSW }

final statusValues = EnumValues({
  "Tepat Waktu": Status.TEPAT_WAKTU,
  "Terlambat Toleransi": Status.TERLAMBAT_TOLERANSI,
  "Terlambat Toleransi & PSW": Status.TERLAMBAT_TOLERANSI_PSW
});

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
