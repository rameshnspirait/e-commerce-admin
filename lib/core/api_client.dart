import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'app_storage.dart';
import 'constants.dart';
import '../routes/app_routes.dart';

class ApiClient {
  static Uri _uri(String path) => Uri.parse('${AppConstants.baseUrl}$path');

  // ================= HEADERS =================
  static Map<String, String> _headers({bool auth = true}) {
    final token = AppStorage.accessToken;

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (auth && token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ================= GET =================
  static Future<http.Response> get(String path) async {
    final response = await http.get(_uri(path), headers: _headers());
    _handleAuthError(response);
    return response;
  }

  // ================= POST =================
  static Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final response = await http.post(
      _uri(path),
      headers: _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    _handleAuthError(response);
    return response;
  }

  // ================= PUT =================
  static Future<http.Response> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await http.put(
      _uri(path),
      headers: _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
    _handleAuthError(response);
    return response;
  }

  // ================= DELETE =================
  static Future<http.Response> delete(String path) async {
    final response = await http.delete(_uri(path), headers: _headers());
    _handleAuthError(response);
    return response;
  }

  // ================= AUTH ERROR HANDLER =================
  static void _handleAuthError(http.Response response) {
    if (response.statusCode == 401) {
      // Token expired or invalid
      AppStorage.clear();
      Get.offAllNamed(Routes.login);
    }
  }
}
