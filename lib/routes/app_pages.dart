import 'package:e_commerce_admin/modules/dashbaord/dashboard_page.dart';
import 'package:get/get.dart';
import '../modules/auth/login_page.dart';
import '../modules/products/product_page.dart';
import '../layout/admin_layout.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(
      name: '/dashboard',
      page: () => AdminLayout(child: DashboardPage()),
    ),
    GetPage(
      name: '/products',
      page: () => AdminLayout(child: ProductPage()),
    ),
  ];
}
