import 'package:e_commerce_admin/layout/topbar.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              children: [
                TopBar(),
                Expanded(
                  child: Padding(padding: EdgeInsets.all(16), child: child),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
