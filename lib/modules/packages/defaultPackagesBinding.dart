import 'package:get/get.dart';

import 'DefaultPackageController.dart';





class DefaultPackageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DefaultPackageController>(
            () => DefaultPackageController(apiRepository: Get.find()));
  }
}
