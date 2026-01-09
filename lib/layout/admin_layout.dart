import 'package:e_commerce_admin/layout/topbar.dart';
import 'package:e_commerce_admin/modules/dashbaord/dashboard_page.dart';
import 'package:e_commerce_admin/modules/products/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sidebar.dart';
import 'sidebar_controller.dart';

class AdminLayout extends StatelessWidget {
  AdminLayout({super.key});

  final SidebarController sidebarCtrl = Get.find();

  final pages = [DashboardPage(), ProductPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Row(
        children: [
          /// ===== SIDEBAR =====
          SidebarWidget(),

          /// ===== MAIN AREA =====
          Expanded(
            child: Column(
              children: [
                /// TOP BAR
                TopBarWidget(),

                /// PAGE CONTENT
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: sidebarCtrl.currentIndex.value,
                      children: pages,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
