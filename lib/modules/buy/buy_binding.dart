import 'package:get/get.dart';

import 'buy_controller.dart';



class BuyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyController>(
            () => BuyController(apiRepository: Get.find()));
  }
}
