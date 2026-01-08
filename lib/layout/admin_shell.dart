import 'package:e_commerce_admin/layout/sidebar.dart';
import 'package:e_commerce_admin/modules/dashbaord/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sidebar_controller.dart';
import '../modules/products/product_page.dart';

class AdminShell extends StatelessWidget {
  AdminShell({super.key});

  final SidebarController sidebarCtrl = Get.put(
    SidebarController(),
    permanent: true,
  );

  final pages = [DashboardPage(), ProductPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarWidget(),
          Expanded(
            child: Obx(() {
              return IndexedStack(
                index: sidebarCtrl.currentIndex.value,
                children: pages,
              );
            }),
          ),
        ],
      ),
    );
  }
}
