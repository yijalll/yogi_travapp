// To parse this JSON data, do
//
//     final districtResponse = districtResponseFromJson(jsonString);

import 'dart:convert';

List<DistrictResponse> districtResponseFromJson(String str) =>
    List<DistrictResponse>.from(
        json.decode(str).map((x) => DistrictResponse.fromJson(x)));

String districtResponseToJson(List<DistrictResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictResponse {
  final String id;
  final String regencyId;
  final String name;

  DistrictResponse({
    required this.id,
    required this.regencyId,
    required this.name,
  });

  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      DistrictResponse(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
      };
}
