import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //static const String baseUrl = "http://10.0.2.2:8000/api"; // Android Emulator
  static const String baseUrl = "http://192.168.1.115:8000/api"; // Address IP de ma machine

  /// GET request
  static Future<dynamic> get(String endpoint) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: _headers(token),
    );
    return _handleResponse(response);
  }

  /// POST request
  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: _headers(token),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// PUT request
  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/$endpoint"),
      headers: _headers(token),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// DELETE request
  static Future<dynamic> delete(String endpoint) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/$endpoint"),
      headers: _headers(token),
    );
    return _handleResponse(response);
  }

  /// --- Utils internes ---
  static Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static dynamic _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['message'] ?? "Erreur serveur");
    }
  }
}
