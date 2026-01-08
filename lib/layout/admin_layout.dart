import 'package:e_commerce_admin/layout/sidebar.dart';
import 'package:e_commerce_admin/modules/dashbaord/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/products/product_page.dart';
import 'sidebar_controller.dart';

class AdminLayout extends StatelessWidget {
  AdminLayout({super.key});

  final SidebarController sidebarCtrl = Get.put(
    SidebarController(),
    permanent: true,
  );

  final List<Widget> pages = [DashboardPage(), ProductPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // ================= SIDEBAR =================
          SidebarWidget(),

          // ================= MAIN CONTENT =================
          Expanded(
            child: Column(
              children: [
                // ===== TOP APP BAR =====
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          sidebarCtrl.currentIndex.value == 0
                              ? 'Dashboard'
                              : 'Products',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // Optional: profile avatar, notifications, etc
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(
                            Icons.person,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ===== PAGE CONTENT =====
                Expanded(
                  child: Obx(() {
                    int currentIndex = sidebarCtrl.currentIndex.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: IndexedStack(
                        index: currentIndex,
                        children: pages.map((page) {
                          if (page is ProductPage) {
                            page.ctrl.onVisible(currentIndex == 1);
                          } else if (page is DashboardPage) {
                            // page.onVisible(currentIndex == 0);
                          }
                          return page;
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
