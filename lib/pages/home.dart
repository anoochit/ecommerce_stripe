import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_stripe/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_stripe/controllers/home_controller.dart';
import 'package:flutter_ecommerce_stripe/models/cart_item.dart';
import 'package:flutter_ecommerce_stripe/models/product.dart';
import 'package:flutter_ecommerce_stripe/widgets/cart_button.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("eCommerce"),
        actions: const [
          CartButton(),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          final products = controller.getProducts();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => addToCart(products, index),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: LayoutBuilder(builder: (context, constrains) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: constrains.maxWidth,
                          color: Colors.blue.shade100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(products[index].title),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('${products[index].price}'),
                        )
                      ],
                    );
                  }),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addToCart(List<Product> products, int index) {
    cartController.addToCart(
      item: CartItem(
        id: products[index].id,
        quantity: 1,
        price: products[index].price,
      ),
    );
  }
}
