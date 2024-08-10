import 'package:http/http.dart' as http;
import 'package:tour_and_travel/core/variables.dart';
import 'package:tour_and_travel/models/base_error_response.dart';
import 'package:tour_and_travel/models/send_package_request.dart';
import 'package:tour_and_travel/services/auth_service.dart';

class PackageService {
  final authService = AuthService();

  Future<bool> sendPackage(SendPackageRequest request) async {
    final token = await authService.getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/paket'),
      headers: headers,
      body: sendPackageRequestToJson(request),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }
}
