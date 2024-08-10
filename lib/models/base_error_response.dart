// To parse this JSON data, do
//
//     final baseErrorResponse = baseErrorResponseFromJson(jsonString);

import 'dart:convert';

BaseErrorResponse baseErrorResponseFromJson(String str) =>
    BaseErrorResponse.fromJson(json.decode(str));

String baseErrorResponseToJson(BaseErrorResponse data) =>
    json.encode(data.toJson());

class BaseErrorResponse {
  final String? message;

  BaseErrorResponse({
    this.message,
  });

  factory BaseErrorResponse.fromJson(Map<String, dynamic> json) =>
      BaseErrorResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
