import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../core/storage.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await storage.write(key: 'access', value: data['access']);
      await storage.write(key: 'refresh', value: data['refresh']);
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    return await storage.read(key: 'access') != null;
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }
}
