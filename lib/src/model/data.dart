import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';

class AppData {
  static List<Product> productList = [
    Product(
        id:1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now"),
    Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
  ];
  static List<Category> categoryList = [
    Category(),
    Category(
        name: "Sneakers",
        image: 'assets/shoe_thumb_tilt.png',
        isSelected: true),
    Category(id:1,name: "Watch", image: 'assets/watch.png'),
    Category(id:2,name: "Jacket", image: 'assets/jacket.png'),
    Category(id:3,name: "Watch", image: 'assets/watch.png'),
    Category(id:4,name: "Watch", image: 'assets/watch.png'),
  ];
}
