// To parse this JSON data, do
//
//     final regencyResponse = regencyResponseFromJson(jsonString);

import 'dart:convert';

List<RegencyResponse> regencyResponseFromJson(String str) =>
    List<RegencyResponse>.from(
        json.decode(str).map((x) => RegencyResponse.fromJson(x)));

String regencyResponseToJson(List<RegencyResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegencyResponse {
  final String id;
  final String provinceId;
  final String name;

  RegencyResponse({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  factory RegencyResponse.fromJson(Map<String, dynamic> json) =>
      RegencyResponse(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
