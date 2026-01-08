import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'core/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await storage.read(key: 'access');

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
