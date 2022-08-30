import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/cart');
      },
      child: GetBuilder<CartController>(
        init: CartController(),
        builder: ((controller) {
          return Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_bag,
                  size: 32,
                ),
              ),
              (controller.getCartItemCount() > 0)
                  ? Positioned(
                      top: 1,
                      right: 1,
                      child: ClipOval(
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          color: Colors.red,
                          child: Text(
                            ' ${controller.getCartItemCount()} ',
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
