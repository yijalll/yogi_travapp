// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String? token;
  final String? refreshToken;

  LoginResponse({
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refresh_token": refreshToken,
      };
}
