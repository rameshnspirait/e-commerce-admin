import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sidebar_controller.dart';

class SidebarWidget extends StatelessWidget {
  SidebarWidget({super.key});

  final SidebarController ctrl = Get.find();

  final menuItems = const [
    {'icon': Icons.dashboard, 'title': 'Dashboard'},
    {'icon': Icons.shopping_bag, 'title': 'Products'},
  ];

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
          const SizedBox(height: 20),
          Obx(() {
            return Column(
              children: List.generate(menuItems.length, (index) {
                final selected = ctrl.currentIndex.value == index;
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: selected ? Colors.blue : Colors.white,
                  ),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      color: selected ? Colors.blue : Colors.white,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: selected,
                  selectedTileColor: Colors.white.withOpacity(0.1),
                  onTap: () {
                    ctrl.changeIndex(index);
                  },
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
