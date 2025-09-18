import 'package:e_commerce_code_pixel/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl,
                height: 250, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(product.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
