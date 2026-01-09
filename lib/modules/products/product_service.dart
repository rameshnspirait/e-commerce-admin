import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import 'product_model.dart';

class ProductService {
  final _box = GetStorage();

  // ================= TOKEN =================
  String _getTokenSync() {
    final token = _box.read<String>('access');
    if (token == null || token.isEmpty) {
      throw Exception('Access token not found');
    }
    return token;
  }

  // ================= FETCH =================
  Future<List<Product>> fetchProducts() async {
    final token = _getTokenSync();

    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}/api/products/'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch products (${response.statusCode})');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  // ================= CREATE =================
  Future<void> createProduct({
    required Map<String, dynamic> data,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final token = _getTokenSync();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConstants.baseUrl}/api/products/'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    if (imageBytes != null && imageName != null) {
      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes, filename: imageName),
      );
    }

    final response = await request.send();

    if (response.statusCode != 201) {
      final body = await response.stream.bytesToString();
      throw Exception('Create failed: $body');
    }
  }

  // ================= UPDATE =================
  Future<void> updateProduct({
    required int id,
    required Map<String, dynamic> data,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final token = _getTokenSync();

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('${AppConstants.baseUrl}/api/products/$id/'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    if (imageBytes != null && imageName != null) {
      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes, filename: imageName),
      );
    }

    final response = await request.send();

    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw Exception('Update failed: $body');
    }
  }

  // ================= DELETE =================
  Future<void> deleteProduct(int id) async {
    final token = _getTokenSync();

    final response = await http.delete(
      Uri.parse('${AppConstants.baseUrl}/api/products/$id/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 204) {
      throw Exception('Delete failed (${response.statusCode})');
    }
  }
}
