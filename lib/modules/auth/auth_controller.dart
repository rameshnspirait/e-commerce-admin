import 'package:get/get.dart';
import 'auth_service.dart';
import '../../routes/app_routes.dart';
import '../../core/error_handler.dart';

class AuthController extends GetxController {
  final AuthService _service = AuthService();
  var loading = false.obs;

  Future<void> login(String user, String pass) async {
    try {
      loading.value = true;
      await _service.login(user, pass);
      Get.offAllNamed(Routes.dashboard);
    } catch (e) {
      ErrorHandler.show(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    Get.offAllNamed(Routes.login);
  }
}
