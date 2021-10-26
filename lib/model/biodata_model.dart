// To parse this JSON data, do
//
//     final biodataModel = biodataModelFromJson(jsonString);

import 'dart:convert';

BiodataModel biodataModelFromJson(String? str) =>
    BiodataModel.fromJson(json.decode(str!));

String biodataModelToJson(BiodataModel data) => json.encode(data.toJson());

class BiodataModel {
  BiodataModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataBiodata data;
  String message;

  factory BiodataModel.fromJson(Map<String, dynamic> json) => BiodataModel(
        success: json["success"],
        data: DataBiodata.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class DataBiodata {
  DataBiodata({
    required this.id,
    required this.nik,
    required this.nama,
    required this.jk,
    required this.jbtn,
    required this.jnjJabatan,
    required this.kodeKelompok,
    required this.kodeResiko,
    required this.kodeEmergency,
    required this.departemen,
    required this.bidang,
    required this.sttsWp,
    required this.sttsKerja,
    required this.npwp,
    required this.pendidikan,
    required this.gapok,
    required this.tmpLahir,
    required this.tglLahir,
    required this.alamat,
    required this.kota,
    required this.mulaiKerja,
    required this.msKerja,
    required this.indexins,
    required this.bpd,
    required this.rekening,
    required this.sttsAktif,
    required this.wajibmasuk,
    required this.pengurang,
    required this.indek,
    required this.mulaiKontrak,
    required this.cutiDiambil,
    required this.dankes,
    required this.photo,
    required this.noKtp,
    required this.email,
  });

  int? id;
  String? nik;
  String? nama;
  String? jk;
  String? jbtn;
  String? jnjJabatan;
  String? kodeKelompok;
  String? kodeResiko;
  String? kodeEmergency;
  String? departemen;
  String? bidang;
  String? sttsWp;
  String? sttsKerja;
  String? npwp;
  String? pendidikan;
  int? gapok;
  String? tmpLahir;
  DateTime? tglLahir;
  String? alamat;
  String? kota;
  DateTime? mulaiKerja;
  String? msKerja;
  String? indexins;
  String? bpd;
  String? rekening;
  String? sttsAktif;
  int? wajibmasuk;
  int? pengurang;
  int? indek;
  DateTime? mulaiKontrak;
  int? cutiDiambil;
  int? dankes;
  String? photo;
  String? noKtp;
  String? email;

  factory DataBiodata.fromJson(Map<String, dynamic> json) => DataBiodata(
        id: json["id"],
        nik: json["nik"],
        nama: json["nama"],
        jk: json["jk"],
        jbtn: json["jbtn"],
        jnjJabatan: json["jnj_jabatan"],
        kodeKelompok: json["kode_kelompok"],
        kodeResiko: json["kode_resiko"],
        kodeEmergency: json["kode_emergency"],
        departemen: json["departemen"],
        bidang: json["bidang"],
        sttsWp: json["stts_wp"],
        sttsKerja: json["stts_kerja"],
        npwp: json["npwp"],
        pendidikan: json["pendidikan"],
        gapok: json["gapok"],
        tmpLahir: json["tmp_lahir"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        alamat: json["alamat"],
        kota: json["kota"],
        mulaiKerja: DateTime.parse(json["mulai_kerja"]),
        msKerja: json["ms_kerja"],
        indexins: json["indexins"],
        bpd: json["bpd"],
        rekening: json["rekening"],
        sttsAktif: json["stts_aktif"],
        wajibmasuk: json["wajibmasuk"],
        pengurang: json["pengurang"],
        indek: json["indek"],
        mulaiKontrak: DateTime.parse(json["mulai_kontrak"]),
        cutiDiambil: json["cuti_diambil"],
        dankes: json["dankes"],
        photo: json["photo"],
        noKtp: json["no_ktp"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "nama": nama,
        "jk": jk,
        "jbtn": jbtn,
        "jnj_jabatan": jnjJabatan,
        "kode_kelompok": kodeKelompok,
        "kode_resiko": kodeResiko,
        "kode_emergency": kodeEmergency,
        "departemen": departemen,
        "bidang": bidang,
        "stts_wp": sttsWp,
        "stts_kerja": sttsKerja,
        "npwp": npwp,
        "pendidikan": pendidikan,
        "gapok": gapok,
        "tmp_lahir": tmpLahir,
        "tgl_lahir":
            "${tglLahir!.year.toString().padLeft(4, '0')}-${tglLahir!.month.toString().padLeft(2, '0')}-${tglLahir!.day.toString().padLeft(2, '0')}",
        "alamat": alamat,
        "kota": kota,
        "mulai_kerja":
            "${mulaiKerja!.year.toString().padLeft(4, '0')}-${mulaiKerja!.month.toString().padLeft(2, '0')}-${mulaiKerja!.day.toString().padLeft(2, '0')}",
        "ms_kerja": msKerja,
        "indexins": indexins,
        "bpd": bpd,
        "rekening": rekening,
        "stts_aktif": sttsAktif,
        "wajibmasuk": wajibmasuk,
        "pengurang": pengurang,
        "indek": indek,
        "mulai_kontrak":
            "${mulaiKontrak!.year.toString().padLeft(4, '0')}-${mulaiKontrak!.month.toString().padLeft(2, '0')}-${mulaiKontrak!.day.toString().padLeft(2, '0')}",
        "cuti_diambil": cutiDiambil,
        "dankes": dankes,
        "photo": photo,
        "no_ktp": noKtp,
        "email": email,
      };
}
