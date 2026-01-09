import 'package:get/get.dart';
import 'product_service.dart';
import 'product_model.dart';
import '../../core/error_handler.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  final RxList<Product> products = <Product>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      loading.value = true;
      products.value = await _service.fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      loading.value = false;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _service.deleteProduct(id);
      fetchProducts();
    } catch (e) {
      ErrorHandler.show('Delete failed');
    }
  }
}
