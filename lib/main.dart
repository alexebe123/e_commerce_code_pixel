import 'package:e_commerce_code_pixel/screen/home_screen.dart';
import 'package:e_commerce_code_pixel/screen/product_detail_screen.dart';
import 'package:e_commerce_code_pixel/screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// استورد الموديل و البيانات هنا

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/products/:category',
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return ProductsPage(category: category);
        },
      ),
      GoRoute(
        path: "/product",
        /* path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final product = AppConste().dummyProducts.firstWhere(
            (prod) => prod.id == id,
          );
          return ProductDetailScreen();
        },*/
        builder: (context, state) => ProductDetailScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
