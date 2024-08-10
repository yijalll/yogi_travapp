// To parse this JSON data, do
//
//     final sendPackageRequest = sendPackageRequestFromJson(jsonString);

import 'dart:convert';

SendPackageRequest sendPackageRequestFromJson(String str) =>
    SendPackageRequest.fromJson(json.decode(str));

String sendPackageRequestToJson(SendPackageRequest data) =>
    json.encode(data.toJson());

class SendPackageRequest {
  final String isi;
  final Pen pengirim;
  final Pen penerima;

  SendPackageRequest({
    required this.isi,
    required this.pengirim,
    required this.penerima,
  });

  factory SendPackageRequest.fromJson(Map<String, dynamic> json) =>
      SendPackageRequest(
        isi: json["isi"],
        pengirim: Pen.fromJson(json["pengirim"]),
        penerima: Pen.fromJson(json["penerima"]),
      );

  Map<String, dynamic> toJson() => {
        "isi": isi,
        "pengirim": pengirim.toJson(),
        "penerima": penerima.toJson(),
      };

  SendPackageRequest copyWith({
    String? isi,
    Pen? pengirim,
    Pen? penerima,
  }) {
    return SendPackageRequest(
      isi: isi ?? this.isi,
      pengirim: pengirim ?? this.pengirim,
      penerima: penerima ?? this.penerima,
    );
  }
}

class Pen {
  final String nama;
  final String telp;
  final String alamat;
  final String provinsi;
  final String kotaKab;
  final String kecamatan;
  final String kelurahan;

  Pen({
    required this.nama,
    required this.telp,
    required this.alamat,
    required this.provinsi,
    required this.kotaKab,
    required this.kecamatan,
    required this.kelurahan,
  });

  factory Pen.fromJson(Map<String, dynamic> json) => Pen(
        nama: json["nama"],
        telp: json["telp"],
        alamat: json["alamat"],
        provinsi: json["provinsi"],
        kotaKab: json["kota_kab"],
        kecamatan: json["kecamatan"],
        kelurahan: json["kelurahan"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "telp": telp,
        "alamat": alamat,
        "provinsi": provinsi,
        "kota_kab": kotaKab,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
      };

  Pen copyWith({
    String? nama,
    String? telp,
    String? alamat,
    String? provinsi,
    String? kotaKab,
    String? kecamatan,
    String? kelurahan,
  }) {
    return Pen(
      nama: nama ?? this.nama,
      telp: telp ?? this.telp,
      alamat: alamat ?? this.alamat,
      provinsi: provinsi ?? this.provinsi,
      kotaKab: kotaKab ?? this.kotaKab,
      kecamatan: kecamatan ?? this.kecamatan,
      kelurahan: kelurahan ?? this.kelurahan,
    );
  }
}
