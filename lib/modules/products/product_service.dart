import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../core/storage.dart';
import 'product_model.dart';

class ProductService {
  Future<String?> _token() async => await storage.read(key: 'access');

  Future<List<Product>> fetchProducts() async {
    final res = await http.get(
      Uri.parse('${AppConstants.baseUrl}/api/products/'),
      headers: {'Authorization': 'Bearer ${await _token()}'},
    );

    final data = jsonDecode(res.body) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<void> createProduct(Map<String, dynamic> data) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConstants.baseUrl}/api/products/'),
    );

    request.headers['Authorization'] = 'Bearer ${await _token()}';
    data.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    await request.send();
  }

  Future<void> updateProduct(int id, Map<String, dynamic> data) async {
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('${AppConstants.baseUrl}/api/products/$id/'),
    );

    request.headers['Authorization'] = 'Bearer ${await _token()}';
    data.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    await request.send();
  }

  Future<void> deleteProduct(int id) async {
    await http.delete(
      Uri.parse('${AppConstants.baseUrl}/api/products/$id/'),
      headers: {'Authorization': 'Bearer ${await _token()}'},
    );
  }
}
