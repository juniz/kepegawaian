// To parse this JSON data, do
//
//     final jadwalPegawaiModel = jadwalPegawaiModelFromJson(jsonString);

import 'dart:convert';

JadwalPegawaiModel jadwalPegawaiModelFromJson(String str) =>
    JadwalPegawaiModel.fromJson(json.decode(str));

String jadwalPegawaiModelToJson(JadwalPegawaiModel data) =>
    json.encode(data.toJson());

class JadwalPegawaiModel {
  JadwalPegawaiModel({
    this.id,
    this.tahun,
    this.bulan,
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
    this.h7,
    this.h8,
    this.h9,
    this.h10,
    this.h11,
    this.h12,
    this.h13,
    this.h14,
    this.h15,
    this.h16,
    this.h17,
    this.h18,
    this.h19,
    this.h20,
    this.h21,
    this.h22,
    this.h23,
    this.h24,
    this.h25,
    this.h26,
    this.h27,
    this.h28,
    this.h29,
    this.h30,
    this.h31,
  });

  int? id;
  int? tahun;
  String? bulan;
  String? h1;
  String? h2;
  String? h3;
  String? h4;
  String? h5;
  String? h6;
  String? h7;
  String? h8;
  String? h9;
  String? h10;
  String? h11;
  String? h12;
  String? h13;
  String? h14;
  String? h15;
  String? h16;
  String? h17;
  String? h18;
  String? h19;
  String? h20;
  String? h21;
  String? h22;
  String? h23;
  String? h24;
  String? h25;
  String? h26;
  String? h27;
  String? h28;
  String? h29;
  String? h30;
  String? h31;

  factory JadwalPegawaiModel.fromJson(Map<String, dynamic> json) =>
      JadwalPegawaiModel(
        id: json["id"],
        tahun: json["tahun"],
        bulan: json["bulan"],
        h1: json["h1"],
        h2: json["h2"],
        h3: json["h3"],
        h4: json["h4"],
        h5: json["h5"],
        h6: json["h6"],
        h7: json["h7"],
        h8: json["h8"],
        h9: json["h9"],
        h10: json["h10"],
        h11: json["h11"],
        h12: json["h12"],
        h13: json["h13"],
        h14: json["h14"],
        h15: json["h15"],
        h16: json["h16"],
        h17: json["h17"],
        h18: json["h18"],
        h19: json["h19"],
        h20: json["h20"],
        h21: json["h21"],
        h22: json["h22"],
        h23: json["h23"],
        h24: json["h24"],
        h25: json["h25"],
        h26: json["h26"],
        h27: json["h27"],
        h28: json["h28"],
        h29: json["h29"],
        h30: json["h30"],
        h31: json["h31"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tahun": tahun,
        "bulan": bulan,
        "h1": h1,
        "h2": h2,
        "h3": h3,
        "h4": h4,
        "h5": h5,
        "h6": h6,
        "h7": h7,
        "h8": h8,
        "h9": h9,
        "h10": h10,
        "h11": h11,
        "h12": h12,
        "h13": h13,
        "h14": h14,
        "h15": h15,
        "h16": h16,
        "h17": h17,
        "h18": h18,
        "h19": h19,
        "h20": h20,
        "h21": h21,
        "h22": h22,
        "h23": h23,
        "h24": h24,
        "h25": h25,
        "h26": h26,
        "h27": h27,
        "h28": h28,
        "h29": h29,
        "h30": h30,
        "h31": h31,
      };
}
