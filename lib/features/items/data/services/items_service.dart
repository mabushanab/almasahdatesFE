import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:http/http.dart' as http;

class ItemService {
  // final String baseUrl = 'http://localhost:9090/item'; // for Android emulator
  final _authService = AuthService();
  // final String token = _authService.getToken();

  // String _loadToken() async {
  //   String? token = await _authService.getToken();
  //   return token;
  // }

  Future<List> list() async {
    final url = Uri.parse('$baseUrl/list');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<List> item(String name) async {
    final url = Uri.parse('$baseUrl/$name');
    Future<String?> token = _authService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  Future<List<Item>> fetchItems() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/item/list');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}

//   Future<bool> login(String username, String password) async {
//     final url = Uri.parse('$baseUrl/auth/login');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'username': username, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       await storage.write(key: 'token', value: data['token']);
//       return true;
//     }
//     return false;
//   }

//   Future<String?> getToken() async {
//     return await storage.read(key: 'token');
//   }

//   Future<void> logout() async {
//     await storage.delete(key: 'token');
//   }
// }
