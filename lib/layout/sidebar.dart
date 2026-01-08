import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey.shade900,
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'ADMIN PANEL',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          _menuItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Get.offNamed(Routes.dashboard),
          ),

          _menuItem(
            icon: Icons.shopping_bag,
            title: 'Products',
            onTap: () => Get.offNamed(Routes.products),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
