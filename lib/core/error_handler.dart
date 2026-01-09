import 'package:get/get.dart';

class ErrorHandler {
  static void show(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
