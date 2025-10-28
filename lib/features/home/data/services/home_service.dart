import 'package:almasah_dates/core/constants/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeService {
  // final String baseUrl = 'http://localhost:9090'; // for Android emulator
  final storage = const FlutterSecureStorage();

  Future<bool> register(String username, String password) async {
    final url = Uri.parse('$baseUrl/home/CDD');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}
