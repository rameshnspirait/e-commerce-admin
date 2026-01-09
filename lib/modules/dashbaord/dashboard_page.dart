import 'package:e_commerce_admin/modules/dashbaord/dashboard_controller.dart';
import 'package:e_commerce_admin/modules/products/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardController ctrl = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              children: [
                _card('Products', Icons.shopping_bag, 0),
                SizedBox(width: 16),
                _card('Orders', Icons.receipt, 1),
                SizedBox(width: 16),
                _card('Users', Icons.people, 2),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // ================= PAGE CONTENT =================
          Expanded(
            child: Obx(() {
              switch (ctrl.selectedIndex.value) {
                case 0:
                  return ProductPage();
                case 1:
                  return Center(
                    child: Text('Orders Page'),
                  ); // Replace with your OrdersPage
                case 2:
                  return Center(
                    child: Text('Users Page'),
                  ); // Replace with your UsersPage
                default:
                  return ProductPage();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, IconData icon, int index) {
    return Expanded(
      child: Obx(() {
        final selected = ctrl.selectedIndex.value == index;
        return GestureDetector(
          onTap: () => ctrl.select(index),
          child: Card(
            color: selected ? Colors.black.withOpacity(0.3) : Colors.white,
            elevation: selected ? 10 : 6,
            shadowColor: selected ? Colors.black : Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: selected
                  ? BorderSide(color: Colors.grey, width: 2)
                  : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: selected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
