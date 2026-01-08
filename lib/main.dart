import 'package:e_commerce_admin/layout/sidebar_controller.dart';
import 'package:e_commerce_admin/modules/products/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'core/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await storage.read(key: 'access');
  // Make SidebarController permanent and globally accessible
  Get.put(SidebarController(), permanent: true);

  // Also your ProductController
  Get.put(ProductController(), permanent: true);

  runApp(MyApp(initialRoute: token == null ? Routes.login : Routes.dashboard));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
