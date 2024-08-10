// To parse this JSON data, do
//
//     final transactionRequest = transactionRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

String transactionRequestToJson(TransactionRequest data) =>
    json.encode(data.toJson());

class TransactionRequest {
  final int jurusanId;
  final String nama;
  final String telp;
  final String jk;
  final int ispaid;
  final String alamat;
  final String kontakDarurat;
  final File file;

  TransactionRequest({
    required this.jurusanId,
    required this.nama,
    required this.telp,
    required this.jk,
    required this.ispaid,
    required this.alamat,
    required this.kontakDarurat,
    required this.file,
  });

  Map<String, String> toJson() => {
        "jurusan_id": '$jurusanId',
        "nama": nama,
        "telp": telp,
        "jk": jk,
        "ispaid": '$ispaid',
        "alamat": alamat,
        "kontak_darurat": kontakDarurat,
      };
}
