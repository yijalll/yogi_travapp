// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  final User? data;

  UserResponse({
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? refreshToken;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.refreshToken,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        refreshToken: json["refresh_token"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "refresh_token": refreshToken,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
