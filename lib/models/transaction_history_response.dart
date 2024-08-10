// To parse this JSON data, do
//
//     final transactionHistoryResponse = transactionHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tour_and_travel/core/colors.dart';

TransactionHistoryResponse transactionHistoryResponseFromJson(String str) =>
    TransactionHistoryResponse.fromJson(json.decode(str));

String transactionHistoryResponseToJson(TransactionHistoryResponse data) =>
    json.encode(data.toJson());

class TransactionHistoryResponse {
  final List<TransactionHistory>? data;
  final String? message;

  TransactionHistoryResponse({
    this.data,
    this.message,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryResponse(
        data: json["data"] == null
            ? []
            : List<TransactionHistory>.from(
                json["data"]!.map((x) => TransactionHistory.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class TransactionHistory {
  final int? id;
  final Jurusan? jurusan;
  final User? user;
  final bool? ispaid;
  final String? buktiBayar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionHistory({
    this.id,
    this.jurusan,
    this.user,
    this.ispaid,
    this.buktiBayar,
    this.createdAt,
    this.updatedAt,
  });

  String get paidStatus {
    if (ispaid ?? false) {
      return "Pemesanan selesai";
    } else {
      return 'Belum dikonfirmasi';
    }
  }

  Color get paidStatusColor {
    if (ispaid ?? false) {
      return AppColors.green;
    } else {
      return AppColors.red;
    }
  }

  IconData get paidStatusIcon {
    final today = DateTime.now();
    final difference = today.difference(createdAt!);
    final daysDifference = difference.inDays;

    if (daysDifference > 2 && ispaid!) {
      return Icons.check_circle;
    } else if (ispaid! && daysDifference <= 2) {
      return Icons.circle;
    } else {
      return Icons.circle;
    }
  }

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["id"],
        jurusan:
            json["jurusan"] == null ? null : Jurusan.fromJson(json["jurusan"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        ispaid: json["ispaid"],
        buktiBayar: json["bukti_bayar"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jurusan": jurusan?.toJson(),
        "user": user?.toJson(),
        "ispaid": ispaid,
        "bukti_bayar": buktiBayar,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Jurusan {
  final int? id;
  final String? nama;

  Jurusan({
    this.id,
    this.nama,
  });

  factory Jurusan.fromJson(Map<String, dynamic> json) => Jurusan(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

class User {
  final String? nama;
  final String? telp;
  final String? jk;
  final int? userId;
  final String? alamat;
  final String? kontakDarurat;

  User({
    this.nama,
    this.telp,
    this.jk,
    this.userId,
    this.alamat,
    this.kontakDarurat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nama: json["nama"],
        telp: json["telp"],
        jk: json["jk"],
        userId: json["user_id"],
        alamat: json["alamat"],
        kontakDarurat: json["kontak_darurat"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "telp": telp,
        "jk": jk,
        "user_id": userId,
        "alamat": alamat,
        "kontak_darurat": kontakDarurat,
      };
}
