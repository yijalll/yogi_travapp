// To parse this JSON data, do
//
//     final ticketResponse = ticketResponseFromJson(jsonString);

import 'dart:convert';

TicketResponse ticketResponseFromJson(String str) =>
    TicketResponse.fromJson(json.decode(str));

String ticketResponseToJson(TicketResponse data) => json.encode(data.toJson());

class TicketResponse {
  final List<Ticket>? data;
  final String? message;

  TicketResponse({
    this.data,
    this.message,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) => TicketResponse(
        data: json["data"] == null
            ? []
            : List<Ticket>.from(json["data"]!.map((x) => Ticket.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Ticket {
  final int? id;
  final Kota? kota;
  final Mobil? mobil;
  final String? jam;
  final DateTime? tanggal;
  final int? harga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ticket({
    this.id,
    this.kota,
    this.mobil,
    this.jam,
    this.tanggal,
    this.harga,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        kota: json["kota"] == null ? null : Kota.fromJson(json["kota"]),
        mobil: json["mobil"] == null ? null : Mobil.fromJson(json["mobil"]),
        jam: json["jam"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        harga: json["harga"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kota": kota?.toJson(),
        "mobil": mobil?.toJson(),
        "jam": jam,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "harga": harga,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Kota {
  final int? id;
  final String? namaKota;

  Kota({
    this.id,
    this.namaKota,
  });

  factory Kota.fromJson(Map<String, dynamic> json) => Kota(
        id: json["id"],
        namaKota: json["nama_kota"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kota": namaKota,
      };
}

class Mobil {
  final int? id;
  final String? namaMobil;

  Mobil({
    this.id,
    this.namaMobil,
  });

  factory Mobil.fromJson(Map<String, dynamic> json) => Mobil(
        id: json["id"],
        namaMobil: json["nama_mobil"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_mobil": namaMobil,
      };
}
