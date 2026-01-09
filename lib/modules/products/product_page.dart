import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'product_controller.dart';
import 'product_form.dart';
import 'product_model.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final ProductController ctrl = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= HEADER =================
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Row(
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
                onPressed: () {
                  Get.dialog(
                    ProductForm(onSuccess: ctrl.fetchProducts),
                    barrierDismissible: false,
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ================= GRID =================
        Expanded(
          child: Obx(() {
            if (ctrl.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (ctrl.products.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PlutoGrid(
                columns: _columns(),
                rows: _rows(ctrl.products),
                configuration: PlutoGridConfiguration(
                  columnSize: const PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.scale,
                  ),
                  style: PlutoGridStyleConfig(
                    gridBorderRadius: BorderRadius.circular(12),
                    gridBorderColor: Colors.grey.shade300,
                    borderColor: Colors.grey.shade300,
                    activatedColor: Colors.blue.withOpacity(0.08),
                    rowHeight: 56,
                    columnHeight: 56,
                    oddRowColor: Colors.grey.shade50,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ================= COLUMNS =================
  List<PlutoColumn> _columns() {
    return [
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.number(),
        width: 60,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Image',
        field: 'image',
        type: PlutoColumnType.text(),
        enableSorting: false,
        width: 80,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (ctx) {
          final String? url = ctx.cell.value;
          if (url == null || url.isEmpty) {
            return const Icon(
              Icons.image_not_supported,
              size: 24,
              color: Colors.grey,
            );
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(url, width: 50, height: 50, fit: BoxFit.cover),
          );
        },
      ),
      PlutoColumn(
        title: 'Product Name',
        field: 'name',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Price',
        field: 'price',
        type: PlutoColumnType.number(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (ctx) => Text(
          '₹${ctx.cell.value}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green.shade700,
          ),
        ),
      ),
      PlutoColumn(
        title: 'Stock',
        field: 'stock',
        type: PlutoColumnType.number(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (ctx) {
          final int stock = ctx.cell.value;
          final bool inStock = stock > 0;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: inStock ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              textAlign: TextAlign.center,
              inStock ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: inStock ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        width: 160,
        enableSorting: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (ctx) {
          final Product product = ctx.cell.value;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _actionButton(
                icon: Icons.edit,
                color: Colors.blue,
                onTap: () {
                  Get.dialog(
                    ProductForm(
                      product: product,
                      onSuccess: ctrl.fetchProducts,
                    ),
                    barrierDismissible: false,
                  );
                },
              ),
              const SizedBox(width: 16),
              _actionButton(
                icon: Icons.delete,
                color: Colors.red,
                onTap: () => _confirmDelete(product.id),
              ),
            ],
          );
        },
      ),
    ];
  }

  // ================= ROWS =================
  List<PlutoRow> _rows(List<Product> products) {
    return products.map((p) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: p.id),
          'image': PlutoCell(value: p.imageUrl), // <-- Add image URL here
          'name': PlutoCell(value: p.name),
          'price': PlutoCell(value: p.price),
          'stock': PlutoCell(value: p.stock),
          'actions': PlutoCell(value: p),
        },
      );
    }).toList();
  }

  // ================= DELETE =================
  void _confirmDelete(int id) {
    Get.defaultDialog(
      title: 'Delete Product',
      middleText: 'Are you sure you want to delete this product?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        await ctrl.deleteProduct(id);
      },
    );
  }

  // ================= ACTION BUTTON =================
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
