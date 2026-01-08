import 'package:e_commerce_admin/modules/products/product_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              _card('Products', Icons.shopping_bag),
              _card('Orders', Icons.receipt),
              _card('Users', Icons.people),
            ],
          ),
          SizedBox(height: 30),
          Expanded(child: ProductPage()),
        ],
      ),
    );
  }

  Widget _card(String title, IconData icon) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(icon, size: 40),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
