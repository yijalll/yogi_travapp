// To parse this JSON data, do
//
//     final villageResponse = villageResponseFromJson(jsonString);

import 'dart:convert';

List<VillageResponse> villageResponseFromJson(String str) =>
    List<VillageResponse>.from(
        json.decode(str).map((x) => VillageResponse.fromJson(x)));

String villageResponseToJson(List<VillageResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VillageResponse {
  final String id;
  final String districtId;
  final String name;

  VillageResponse({
    required this.id,
    required this.districtId,
    required this.name,
  });

  factory VillageResponse.fromJson(Map<String, dynamic> json) =>
      VillageResponse(
        id: json["id"],
        districtId: json["district_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "district_id": districtId,
        "name": name,
      };
}
