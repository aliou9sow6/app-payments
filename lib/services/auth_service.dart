import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthService {

  Future<bool> register(String name, String email, String password, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/register"),
      body: {"name": name, "email": email, "password": password, "password_confirmation": passwordConfirmation},
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      String token = data['token']; // dépend de ton backend
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/login"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token']; // dépend de ton backend
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    await http.post(
      Uri.parse("${ApiConstants.baseUrl}/logout"),
      headers: {"Authorization": "Bearer $token"},
    );

    await prefs.remove("token");
  }
}
