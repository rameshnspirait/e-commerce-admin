import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../core/storage.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  var loading = false.obs;

  Future<void> login(String user, String pass) async {
    loading.value = true;

    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': user, 'password': pass}),
    );

    loading.value = false;

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await storage.write(key: 'access', value: data['access']);
      await storage.write(key: 'refresh', value: data['refresh']);
      Get.offAllNamed(Routes.dashboard);
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    Get.offAllNamed(Routes.login);
  }
}
