import 'package:http/http.dart' as http;
import 'package:tour_and_travel/models/district_response.dart';
import 'package:tour_and_travel/models/province_response.dart';
import 'package:tour_and_travel/models/regency_model.dart';
import 'package:tour_and_travel/models/village_response.dart';

class OpenApiService {
  Future<List<ProvinceResponse>> getProvinces() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/wilayah/provinces'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<ProvinceResponse> items = [];
      final result = provinceResponseFromJson(response.body);
      for (ProvinceResponse item in result) {
        if (item.id == "15" ||
            item.id == "14" ||
            item.id == "21" ||
            item.id == "17" ||
            item.id == "16") {
          items.add(item);
        }
      }
      return items;
    } else {
      throw response.body;
    }
  }

  Future<List<RegencyResponse>> getRegencies(String id) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/wilayah/regencies/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = regencyResponseFromJson(response.body);
      return result;
    } else {
      throw response.body;
    }
  }

  Future<List<DistrictResponse>> getDistricts(String id) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/wilayah/districts/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = districtResponseFromJson(response.body);
      return result;
    } else {
      throw response.body;
    }
  }

  Future<List<VillageResponse>> getVillages(String id) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('https://open-api.my.id/api/wilayah/villages/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = villageResponseFromJson(response.body);
      return result;
    } else {
      throw response.body;
    }
  }
}
