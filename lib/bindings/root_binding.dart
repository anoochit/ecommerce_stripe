import 'package:flutter_ecommerce_stripe/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_stripe/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(HomeController());
    Get.put(CartController());
  }
}
