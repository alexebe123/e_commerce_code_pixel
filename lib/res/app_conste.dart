import 'package:e_commerce_code_pixel/model/product_model.dart';

class AppConste {
  static const imageUrl =
      "https://bpcfdupkxxalmryqdkym.supabase.co/storage/v1/object/public/images/1757761042074.jpg";
  final dummyProducts = [
    ProductModel(
      id: "p1",
      name: "Leather Jacket",
      description: "High quality black leather jacket",
      price: 120.0,
      imageUrl: imageUrl,
      category: "For Him",
    ),
    ProductModel(
      id: "p2",
      name: "Summer Dress",
      description: "Light cotton dress for summer",
      price: 80.0,
      imageUrl: imageUrl,
      category: "For Her",
    ),
    ProductModel(
      id: "p3",
      name: "Kids Sneakers",
      description: "Comfortable sneakers for kids",
      price: 40.0,
      imageUrl: imageUrl,
      category: "Kids",
    ),
  ];
}
