import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/app_storage.dart';
import '../routes/app_routes.dart';
import 'sidebar_controller.dart';

class SidebarWidget extends StatelessWidget {
  SidebarWidget({super.key});

  final SidebarController ctrl = Get.find();

  final menuItems = const [
    {'icon': Icons.dashboard_rounded, 'title': 'Dashboard'},
    {'icon': Icons.shopping_bag_rounded, 'title': 'Products'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF111827), // Dark slate
            Color(0xFF020617), // Almost black
          ],
        ),
      ),
      child: Column(
        children: [
          // ================= BRAND =================
          _buildHeader(),

          // ================= MENU =================
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: menuItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                return Obx(() {
                  final selected = ctrl.currentIndex.value == index;
                  final item = menuItems[index];
                  return _SidebarItem(
                    title: item['title'] as String,
                    icon: item['icon'] as IconData,
                    selected: selected,
                    onTap: () => ctrl.changeIndex(index),
                  );
                });
              },
            ),
          ),

          // ================= LOGOUT =================
          const Divider(color: Colors.white12),

          Padding(
            padding: const EdgeInsets.all(12),
            child: _SidebarItem(
              title: 'Logout',
              icon: Icons.logout_rounded,
              selected: false,
              danger: true,
              onTap: _logout,
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: const [
          Icon(
            Icons.admin_panel_settings_rounded,
            size: 48,
            color: Colors.blueAccent,
          ),
          SizedBox(height: 12),
          Text(
            'ADMIN PANEL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ================= LOGOUT =================
  void _logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      confirmTextColor: Colors.white,
      onConfirm: () {
        AppStorage.clear();
        ctrl.changeIndex(0);
        Get.offAllNamed(Routes.login);
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final bool danger;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger
        ? Colors.redAccent
        : selected
        ? Colors.blueAccent
        : Colors.white70;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: selected
              ? Colors.blueAccent.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Active indicator
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: selected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 14),
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
