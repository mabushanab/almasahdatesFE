import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:http/http.dart' as http;

class ItemService {
  final _authService = AuthService();
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

  Future<void> deleteItem(String name) async {
    final url = Uri.parse('$baseUrl/item/$name');
    String? token = await _authService.getToken();
    await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
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

  Future<void> addItem(Item item) async {
    final url = Uri.parse('$baseUrl/item/create');
    String? token = await _authService.getToken();
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': item.name, 'type': item.type}),
    );
  }

  Future<void> updatePrice(String name, double price) async {
    final url = Uri.parse(
      '$baseUrl/item/setSalePrice',
    ).replace(queryParameters: {'name': name, 'price': price.toString()});
    
    String? token = await _authService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response);
  }
}
