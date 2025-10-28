import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/home/data/models/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeService {
  final storage = const FlutterSecureStorage();
  final _authService = AuthService();

  Future<Home> fetchHomeDetails() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/home/CDD');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data.map((json) => Home.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load homes');
    }
  }
}
