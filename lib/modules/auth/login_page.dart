import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  final ctrl = Get.put(AuthController());
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 12,
          child: Container(
            width: 380,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Admin Login',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: userCtrl,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20),
                Obx(
                  () => ElevatedButton(
                    onPressed: ctrl.loading.value
                        ? null
                        : () => ctrl.login(userCtrl.text, passCtrl.text),
                    child: ctrl.loading.value
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
