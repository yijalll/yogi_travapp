// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  final Register? data;
  final String? message;

  RegisterResponse({
    this.data,
    this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        data: json["data"] == null ? null : Register.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Register {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? role;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Register({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.updatedAt,
    this.createdAt,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        role: json["role"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "role": role,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
