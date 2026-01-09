import 'package:get/get.dart';

class DashboardController extends GetxController {
  // 0 = Products, 1 = Orders, 2 = Users
  var selectedIndex = 0.obs;

  void select(int index) {
    selectedIndex.value = index;
  }
}
