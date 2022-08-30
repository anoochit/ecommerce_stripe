import 'package:get/get.dart';

import '../models/cart_item.dart';

class CartController extends GetxController {
  final RxList<CartItem> _listCartItem = <CartItem>[].obs;

  RxList<CartItem> getCart() {
    return _listCartItem;
  }

  clearCart() {
    _listCartItem.clear();
    update();
  }

  double getCartTotalPrice() {
    return (_listCartItem.isEmpty)
        ? 0.0
        : _listCartItem
            .map(
              (element) => (element.price * element.quantity),
            )
            .reduce(
              (value, element) => (value + element),
            );
  }

  int getCartItemCount() {
    return (_listCartItem.isEmpty)
        ? 0
        : _listCartItem
            .map(
              (element) => element.quantity,
            )
            .reduce(
              (value, element) => (value + element),
            );
  }

  addToCart({required CartItem item}) {
    (_listCartItem
            .where(
              (element) => (element.id == item.id),
            )
            .isEmpty)
        ? _listCartItem.add(item)
        : _listCartItem
            .firstWhere(
              (element) => (element.id == item.id),
            )
            .quantity++;

    update();
  }

  deleteItemFromCart({required String productId}) {
    _listCartItem.removeWhere(
      (element) => (element.id == productId),
    );
    update();
  }
}
