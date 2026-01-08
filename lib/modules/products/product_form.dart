import 'package:flutter/material.dart';
import 'product_service.dart';
import 'product_model.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final VoidCallback onSuccess;

  const ProductForm({this.product, required this.onSuccess});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  bool loading = false;

  final service = ProductService();

  @override
  void initState() {
    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      priceCtrl.text = widget.product!.price.toString();
      stockCtrl.text = widget.product!.stock.toString();
    }
    super.initState();
  }

  Future<void> submit() async {
    setState(() => loading = true);

    final data = {
      'name': nameCtrl.text,
      'price': priceCtrl.text,
      'stock': stockCtrl.text,
    };

    if (widget.product == null) {
      await service.createProduct(data);
    } else {
      await service.updateProduct(widget.product!.id, data);
    }

    setState(() => loading = false);
    widget.onSuccess();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceCtrl,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockCtrl,
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: loading ? null : submit,
          child: loading ? CircularProgressIndicator() : Text('Save'),
        ),
      ],
    );
  }
}
