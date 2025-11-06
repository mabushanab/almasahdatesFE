import 'dart:convert';
import 'dart:typed_data';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/saleOrder/data/models/saleOrder.dart';
import 'package:almasah_dates/features/saleOrder/data/models/saleOrderPerCustomer.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'invoice_stub.dart'
    if (dart.library.html) 'invoice_web.dart'
    if (dart.library.io) 'invoice_io.dart';

class SaleOrderService {
  final _authService = AuthService();

  Future<void> deleteSaleOrder(String name) async {
    final url = Uri.parse('$baseUrl/saleOrder/$name');
    String? token = await _authService.getToken();
    await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
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
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(saleOrder.toJson()),
    );
  }

  Future<String> getMaxProductPrice(String productName) async {
    final url = Uri.parse(
      '$baseUrl/saleOrder/productMinPrice',
    ).replace(queryParameters: {'productName': productName});
    String? token = await _authService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.body;
  }

  Future<String> getProductPrice(String productName) async {
    final url = Uri.parse(
      '$baseUrl/saleOrder/productPrice',
    ).replace(queryParameters: {'productName': productName});
    String? token = await _authService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.body;
  }

  Future<void> payRemain(String sOId) async {
    final url = Uri.parse(
      '$baseUrl/saleOrder/payAllRemainAmount',
    ).replace(queryParameters: {'sOId': sOId});
    String? token = await _authService.getToken();
    await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<void> getInvoice(String sOId) async {
    final url = '$baseUrl/saleOrder/invoice';
    String? token = await _authService.getToken();

    try {
      Dio dio = Dio();

      final response = await dio.get<List<int>>(
        url,
        queryParameters: {'sOId': sOId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          responseType: ResponseType.bytes,
        ),
      );

      final bytes = Uint8List.fromList(response.data!);

      await savePdf(bytes, 'invoice_$sOId.pdf');

      print('PDF downloaded successfully!');
    } catch (e) {
      print('Error downloading invoice: $e');
    }
  }

  Future<SaleOrderPerCustomer> getSaleOrdersForCustomer(String name) async {
    String? token = await _authService.getToken();
    final url = Uri.parse(
      '$baseUrl/saleOrder/SOs',
    ).replace(queryParameters: {'customerName': name});
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      return SaleOrderPerCustomer.fromJson(data);
    } else {
      throw Exception('Failed to load saleOrders');
    }
  }
}
