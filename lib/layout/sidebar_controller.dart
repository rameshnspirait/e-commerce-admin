import 'package:get/get.dart';
import 'topbar_controller.dart';

class SidebarController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final pages = ['Dashboard', 'Products'];

  late TopBarController topBarCtrl;

  @override
  void onInit() {
    super.onInit();
    topBarCtrl = Get.find<TopBarController>();
    topBarCtrl.setTitle(pages[currentIndex.value]);
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    update();
    topBarCtrl.setTitle(pages[index]);
  }
}
