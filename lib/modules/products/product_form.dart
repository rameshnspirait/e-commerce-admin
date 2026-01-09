import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'product_service.dart';
import 'product_model.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final VoidCallback onSuccess;

  const ProductForm({super.key, this.product, required this.onSuccess});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();

  final service = ProductService();
  final picker = ImagePicker();

  Uint8List? imageBytes;
  String? imageName;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      priceCtrl.text = widget.product!.price.toString();
      stockCtrl.text = widget.product!.stock.toString();
    }
  }

  // ================= PICK IMAGE =================
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final bytes = await image.readAsBytes();

    setState(() {
      imageBytes = bytes;
      imageName = image.name;
    });
  }

  // ================= SUBMIT =================
  Future<void> submit() async {
    if (nameCtrl.text.isEmpty ||
        priceCtrl.text.isEmpty ||
        stockCtrl.text.isEmpty) {
      return;
    }

    setState(() => loading = true);

    final data = {
      'name': nameCtrl.text.trim(),
      'price': priceCtrl.text.trim(),
      'stock': stockCtrl.text.trim(),
    };

    try {
      if (widget.product == null) {
        await service.createProduct(
          data: data,
          imageBytes: imageBytes,
          imageName: imageName,
        );
      } else {
        await service.updateProduct(
          id: widget.product!.id,
          data: data,
          imageBytes: imageBytes,
          imageName: imageName,
        );
      }

      widget.onSuccess();
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildImagePreview(),
                ),
              ),
              const SizedBox(height: 16),

              _input(nameCtrl, 'Product Name'),
              const SizedBox(height: 12),
              _input(priceCtrl, 'Price', TextInputType.number),
              const SizedBox(height: 12),
              _input(stockCtrl, 'Stock', TextInputType.number),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: loading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: loading ? null : submit,
          child: loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  // ================= IMAGE PREVIEW =================
  Widget _buildImagePreview() {
    if (imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(imageBytes!, fit: BoxFit.cover),
      );
    }

    if (widget.product?.imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(widget.product!.imageUrl!, fit: BoxFit.cover),
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.upload, size: 32),
          SizedBox(height: 8),
          Text('Click to upload image'),
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController ctrl,
    String label, [
    TextInputType type = TextInputType.text,
  ]) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
