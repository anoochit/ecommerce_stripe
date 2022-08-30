import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_stripe/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_stripe/controllers/home_controller.dart';
import 'package:flutter_ecommerce_stripe/models/cart_item.dart';
import 'package:flutter_ecommerce_stripe/models/product.dart';
import 'package:flutter_ecommerce_stripe/services/stripe_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../widgets/cart_button.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final productController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          final cartItems = controller.getCart();
          final totalPrice = controller.getCartTotalPrice();
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              actions: const [
                CartButton(),
              ],
            ),
            body: buildCart(cartItems, controller),
            bottomNavigationBar: buildCheckoutBar(context, totalPrice, controller),
          );
        });
  }

  Container buildCheckoutBar(BuildContext context, double totalPrice, CartController controller) {
    return Container(
      height: 64,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text("Total"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(totalPrice.toStringAsFixed(2)),
          ),
          ElevatedButton(
            onPressed: () => checkOut(totalPrice, context, controller),
            child: const Text("Payment & Checkout"),
          ),
        ],
      ),
    );
  }

  Future<void> checkOut(double totalPrice, BuildContext context, CartController controller) async {
    try {
      // checkout
      StripeService service = StripeService();
      final payment = await service.createPaymentIntent(
        totalPrice.toStringAsFixed(0),
        'THB',
      );

      await service.stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: payment['client_secret'],
          merchantDisplayName: 'DARTDART',
        ),
      );

      try {
        await service.stripe.presentPaymentSheet().then((value) {
          // clear cart
          controller.clearCart();
          // show completed dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text("Payment completed"),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed('/home');
                    },
                    child: Text("Goto shopping"),
                  )
                ],
              );
            },
          );
        }).onError((error, stackTrace) {
          log('$error $stackTrace');
        });
      } on StripeException catch (e) {
        // show error dialog
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Payment canceled"),
            );
          },
        );
      } catch (e) {
        log('$e');
      }
    } catch (e, s) {
      log('exception = $e$s');
    }
  }

  ListView buildCart(
    RxList<CartItem> cartItems,
    CartController controller,
  ) {
    return ListView(
      children: [
        ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: cartItems.length,
          itemBuilder: (BuildContext context, int index) {
            final product = productController.getProduct(
              productId: cartItems[index].id,
            );
            return buildCartItems(product, cartItems, index, controller);
          },
        ),
      ],
    );
  }

  ListTile buildCartItems(
    Product product,
    RxList<CartItem> cartItems,
    int index,
    CartController controller,
  ) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text('Qt = ${cartItems[index].quantity} '),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${(cartItems[index].quantity * cartItems[index].price)}'),
          GestureDetector(
            onTap: () {
              controller.deleteItemFromCart(productId: cartItems[index].id);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.remove_circle),
            ),
          )
        ],
      ),
    );
  }
}
