import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/app_storage.dart';

class AuthService {
  Future<void> login(String user, String pass) async {
    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': user, 'password': pass}),
    );

    if (res.statusCode != 200) {
      throw Exception('Invalid credentials');
    }

    final data = jsonDecode(res.body);

    // ✅ Save tokens using GetStorage
    await AppStorage.saveTokens(
      access: data['access'],
      refresh: data['refresh'],
    );
  }

  Future<void> logout() async {
    // ✅ Clear all stored data
    AppStorage.clear();
  }
}
