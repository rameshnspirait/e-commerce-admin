import 'package:e_commerce_admin/layout/topbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBarWidget extends StatelessWidget {
  TopBarWidget({super.key});

  final TopBarController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ===== PAGE TITLE =====
          Obx(
            () => Text(
              ctrl.title.value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),

          const Spacer(),

          /// ===== PROFILE =====
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Ramesh Kushwaha',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'rameshkushwaha2021@gmail.com',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person),
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?img=3',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
