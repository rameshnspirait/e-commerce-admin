import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../core/storage.dart';
import 'product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    loading.value = true;
    final token = await storage.read(key: 'access');

    final res = await http.get(
      Uri.parse('${AppConstants.baseUrl}/api/products/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    products.value = (jsonDecode(res.body) as List)
        .map((e) => Product.fromJson(e))
        .toList();

    loading.value = false;
  }

  Future<void> deleteProduct(int id) async {
    final token = await storage.read(key: 'access');

    await http.delete(
      Uri.parse('${AppConstants.baseUrl}/api/products/$id/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    fetchProducts();
  }
}
