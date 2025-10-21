import 'dart:convert';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/marchent/data/models/merchent.dart';
import 'package:http/http.dart' as http;

class MerchantService {
  final _authService = AuthService();


  Future<void> deleteMerchant(String name) async {
    final url = Uri.parse('$baseUrl/merchant/$name');
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

  Future<List<Merchant>> fetchMerchants() async {
    String? token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/merchant/list');
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
      return data.map((json) => Merchant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load merchants');
    }
  }

  Future<void> addMerchant(Merchant merchant) async {
    final url = Uri.parse('$baseUrl/merchant/create');
    String? token = await _authService.getToken();
    print(jsonEncode({'name': merchant.name, 'type': merchant.type}));
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': merchant.name, 'type': merchant.type, 'mobileNumber': merchant.mobileNumber, 'address': merchant.address, 'rate': merchant.rate,
      'notes': merchant.notes
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