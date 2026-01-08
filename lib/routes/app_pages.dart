import 'package:get/get.dart';
import '../modules/auth/login_page.dart';
import '../layout/admin_layout.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/dashboard', page: () => AdminLayout()),
    GetPage(name: '/products', page: () => AdminLayout()),
  ];
}
