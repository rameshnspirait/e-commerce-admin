import 'package:e_commerce_admin/layout/topbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/app_storage.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

import 'layout/sidebar_controller.dart';
import 'modules/auth/auth_controller.dart';
import 'modules/products/product_controller.dart';

Future<void> main() async {
  /// Required for async calls before runApp
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize local storage (GetStorage wrapper)
  await AppStorage.init();

  /// Decide initial route based on token
  final bool isLoggedIn = AppStorage.isLoggedIn;

  /// Register global controllers
  _injectGlobalControllers();

  runApp(MyApp(initialRoute: isLoggedIn ? Routes.dashboard : Routes.login));
}

/// ================= DEPENDENCY INJECTION =================
void _injectGlobalControllers() {
  Get.put<TopBarController>(TopBarController(), permanent: true);

  Get.put<SidebarController>(SidebarController(), permanent: true);

  Get.put<AuthController>(AuthController(), permanent: true);

  Get.put<ProductController>(ProductController(), permanent: true);
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce Admin',
      debugShowCheckedModeBanner: false,

      /// Routing
      initialRoute: initialRoute,
      getPages: AppPages.routes,

      /// Theme
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorSchemeSeed: Colors.blue,
      ),

      /// Global error logging
      logWriterCallback: (text, {isError = false}) {
        if (isError) {
          debugPrint('❌ $text');
        }
      },
    );
  }
}
