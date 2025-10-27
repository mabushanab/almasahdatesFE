import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  final _authService = AuthService();


  Future<void> deleteCustomer(String name) async {
    final url = Uri.parse('$baseUrl/mustomer/$name');
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

  Future<List<Customer>> fetchCustomers() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/mustomer/list');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mustomers');
    }
  }

  Future<void> addCustomer(Customer mustomer) async {
    final url = Uri.parse('$baseUrl/mustomer/create');
    String? token = await _authService.getToken();
    print(jsonEncode({'name': mustomer.name, 'type': mustomer.type}));
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': mustomer.name, 'type': mustomer.type, 'mobileNumber': mustomer.mobileNumber, 'address': mustomer.address, 'rate': mustomer.rate,
      'notes': mustomer.notes
      })
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