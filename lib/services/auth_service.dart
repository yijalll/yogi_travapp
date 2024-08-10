import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_and_travel/core/variables.dart';
import 'package:tour_and_travel/models/base_error_response.dart';
import 'package:tour_and_travel/models/login_request.dart';
import 'package:tour_and_travel/models/login_response.dart';
import 'package:tour_and_travel/models/register_request.dart';
import 'package:tour_and_travel/models/register_response.dart';
import 'package:tour_and_travel/models/user_response.dart';

class AuthService {
  Future<RegisterResponse> register(RegisterRequest request) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/user'),
      headers: headers,
      body: registerRequestToJson(request),
    );

    if (response.statusCode == 201) {
      final result = registerResponseFromJson(response.body);
      return result;
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<UserResponse> login(LoginRequest request) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/login'),
      headers: headers,
      body: loginRequestToJson(request),
    );

    if (response.statusCode == 200) {
      final result = loginResponseFromJson(response.body);
      final token = result.token!;
      await saveToken(token);
      return await getUser();
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<UserResponse> getUser() async {
    final token = await getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/user/profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = userResponseFromJson(response.body);
      await saveUser(result);
      return result;
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<UserResponse> editProfile(RegisterRequest request) async {
    final token = await getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/user/${request.id}'),
      headers: headers,
      body: registerRequestToJson(request),
    );

    if (response.statusCode == 200) {
      return await getUser();
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<void> saveUser(UserResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user_data', userJson);
  }

  Future<UserResponse?> getUserFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserResponse.fromJson(userMap);
    }
    return null;
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final UserResponse user = UserResponse.fromJson(userMap);
      return (user.data?.email ?? '').isNotEmpty;
    }
    return false;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> clearStorageAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return await prefs.remove('user_data');
  }
}
