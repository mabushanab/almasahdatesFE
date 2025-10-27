import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/saleOrder/data/models/saleOrder.dart';
import 'package:http/http.dart' as http;

class SaleOrderService {
  final _authService = AuthService();

  Future<void> deleteSaleOrder(String name) async {
    final url = Uri.parse('$baseUrl/saleOrder/$name');
    String? token = await _authService.getToken();
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    // return jsonDecode(response.body);
  }

  Future<List<SaleOrder>> fetchSaleOrders() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/saleOrder/list');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => SaleOrder.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load saleOrders');
    }
  }

  Future<void> addSaleOrder(SaleOrder saleOrder) async {
    final url = Uri.parse('$baseUrl/saleOrder/create');
    String? token = await _authService.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(saleOrder.toJson()),
    );
    print(response.body);
    // return jsonDecode(response.body);
  }
}



  // Future<List> list() async {
  //   final url = Uri.parse('$baseUrl/list');
  //   final response = await http.get(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //   return jsonDecode(response.body);
  // }

  // Future<List> item(String name) async {
  //   final url = Uri.parse('$baseUrl/$name');
  //   Future<String?> token = _authService.getToken();
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   return jsonDecode(response.body);
  // }