import 'package:get/get.dart';

import 'product_details_controller.dart';




class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
            () => DetailsController(apiRepository: Get.find(), product: null));
  }
}
