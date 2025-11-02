import 'dart:convert';
import 'dart:typed_data';

import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/purchaseOrder/data/models/purchaseOrder.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

// Conditional import for savePdf
import 'invoice_stub.dart'
    if (dart.library.html) 'invoice_web.dart'
    if (dart.library.io) 'invoice_io.dart';

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

  // GET Max Product Price
  Future<String> getMinGoodsPrice(String goodsName) async {
    final url = Uri.parse(
      '$baseUrl/purchaseOrder/goodsMinPrice',
    ).replace(queryParameters: {'goodsName': goodsName});
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


  Future<void> payRemain(String pOId) async {
    final url = Uri.parse(
      '$baseUrl/purchaseOrder/payAllRemainAmount',
    ).replace(queryParameters: {'pOId': pOId});
    String? token = await _authService.getToken();
    await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
  // GET PDF Invoice (cross-platform)
  Future<void> getInvoice(String pOId) async {
    final url = '$baseUrl/purchaseOrder/invoice';
    String? token = await _authService.getToken();

    try {
      Dio dio = Dio();

      final response = await dio.get<List<int>>(
        url,
        queryParameters: {'pOId': pOId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          responseType: ResponseType.bytes,
        ),
      );

      final bytes = Uint8List.fromList(response.data!);

      // Save or download PDF using platform-specific implementation
      await savePdf(bytes, 'invoice_$pOId.pdf');

      print('PDF downloaded successfully!');
    } catch (e) {
      print('Error downloading invoice: $e');
    }
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