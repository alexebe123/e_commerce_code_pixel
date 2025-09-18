import 'package:e_commerce_code_pixel/res/app_conste.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  final String category;

  const ProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final products = AppConste().dummyProducts.where((p) => p.category == category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final product = products[i];
          return InkWell(
            onTap: () => context.go('/product/${product.id}'),
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  Text(product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("\$${product.price.toStringAsFixed(2)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
