import 'package:get/get.dart';

class TopBarController extends GetxController {
  final RxString title = 'Dashboard'.obs;

  void setTitle(String value) {
    title.value = value;
  }
}
