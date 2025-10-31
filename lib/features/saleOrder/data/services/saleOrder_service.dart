import 'dart:convert';
import 'dart:io';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/saleOrder/data/models/saleOrder.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

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


      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/invoice_$sOId.pdf');

      await file.writeAsBytes(response.data!);

      await OpenFilex.open(file.path);

      print('PDF downloaded and opened successfully!');
    } catch (e) {
      print('Error downloading invoice: $e');

    }
  }
}