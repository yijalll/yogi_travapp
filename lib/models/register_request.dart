// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? confPassword;

  RegisterRequest({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.confPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        confPassword: json["confPassword"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confPassword": confPassword,
        "role": "user",
      };
}
