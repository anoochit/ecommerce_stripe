import 'package:get/get.dart';

import '../models/product.dart';

class HomeController extends GetxController {
  // list product
  final List<Product> _listProduct = [
    Product(
      id: "1",
      title: "Product 1",
      description: "product 1 description",
      price: 10.99,
    ),
    Product(
      id: "2",
      title: "Product 2",
      description: "product 2 description",
      price: 20.0,
    ),
    Product(
      id: "3",
      title: "Product 3",
      description: "product 3 description",
      price: 30.0,
    ),
    Product(
      id: "4",
      title: "Product 4",
      description: "product 4 description",
      price: 40.0,
    ),
    Product(
      id: "5",
      title: "Product 5",
      description: "product 5 description",
      price: 30.0,
    ),
    Product(
      id: "6",
      title: "Product 6",
      description: "product 6 description",
      price: 40.0,
    ),
    Product(
      id: "7",
      title: "Product 7",
      description: "product 7 description",
      price: 10.0,
    ),
    Product(
      id: "8",
      title: "Product 8",
      description: "product 8 description",
      price: 20.0,
    ),
    Product(
      id: "9",
      title: "Product 9",
      description: "product 9 description",
      price: 30.0,
    ),
    Product(
      id: "10",
      title: "Product 10",
      description: "product 10 description",
      price: 40.0,
    ),
    Product(
      id: "11",
      title: "Product 11",
      description: "product 11 description",
      price: 30.0,
    ),
    Product(
      id: "12",
      title: "Product 12",
      description: "product 12 description",
      price: 40.0,
    ),
  ];

  List<Product> getProducts() {
    return _listProduct;
  }

  Product getProduct({required String productId}) {
    return _listProduct.firstWhere(
      (element) => (element.id == productId),
    );
  }
}
