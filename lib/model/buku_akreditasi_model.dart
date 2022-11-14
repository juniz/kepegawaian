// To parse this JSON data, do
//
//     final bukuAkreditasi = bukuAkreditasiFromJson(jsonString);

import 'dart:convert';

BukuAkreditasi bukuAkreditasiFromJson(String str) =>
    BukuAkreditasi.fromJson(json.decode(str));

String bukuAkreditasiToJson(BukuAkreditasi data) => json.encode(data.toJson());

class BukuAkreditasi {
  BukuAkreditasi({
    this.file,
    this.daftarIsi,
  });

  String? file;
  List<DaftarIsi>? daftarIsi;

  factory BukuAkreditasi.fromJson(Map<String, dynamic> json) => BukuAkreditasi(
        file: json["file"],
        daftarIsi: List<DaftarIsi>.from(
            json["daftar_isi"].map((x) => DaftarIsi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "daftar_isi": List<dynamic>.from(daftarIsi!.map((x) => x.toJson())),
      };
}

class DaftarIsi {
  DaftarIsi({
    this.halaman,
    this.judul,
  });

  int? halaman;
  String? judul;

  factory DaftarIsi.fromJson(Map<String, dynamic> json) => DaftarIsi(
        halaman: json["halaman"],
        judul: json["judul"],
      );

  Map<String, dynamic> toJson() => {
        "halaman": halaman,
        "judul": judul,
      };
}
