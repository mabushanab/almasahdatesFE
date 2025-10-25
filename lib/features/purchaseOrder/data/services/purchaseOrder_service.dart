import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/purchaseOrder/data/models/purchaseOrder.dart';
import 'package:http/http.dart' as http;

class PurchaseOrderService {
  final _authService = AuthService();

  Future<void> deletePurchaseOrder(String name) async {
    final url = Uri.parse('$baseUrl/purchaseOrder/$name');
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

  Future<List<PurchaseOrder>> fetchPurchaseOrders() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/purchaseOrder/list');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PurchaseOrder.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load purchaseOrders');
    }
  }

  Future<void> addPurchaseOrder(PurchaseOrder purchaseOrder) async {
    final url = Uri.parse('$baseUrl/purchaseOrder/create');
    String? token = await _authService.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(purchaseOrder.toJson()),
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