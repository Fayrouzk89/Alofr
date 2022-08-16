import 'package:get/get.dart';

import 'my_ads_controller.dart';

import '../../globals.dart' as globals;


class MyAdsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAdsController>(
            () => MyAdsController(apiRepository: Get.find(), categoryId: globals.myProducts));
  }
}
