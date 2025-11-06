import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  final _authService = AuthService();

  Future<void> deleteCustomer(String name) async {
    final url = Uri.parse('$baseUrl/customer/$name');
    String? token = await _authService.getToken();
    await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<Customer>> fetchCustomers() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/customer/list');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<void> addCustomer(Customer customer) async {
    final url = Uri.parse('$baseUrl/customer/create');
    String? token = await _authService.getToken();
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': customer.name,
        'type': customer.type,
        'mobileNumber': customer.mobileNumber,
        'address': customer.address,
        'rate': customer.rate,
        'notes': customer.notes,
      }),
    );
  }
}