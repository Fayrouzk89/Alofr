import 'package:get/get.dart';

import 'me_controller.dart';





class MeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeController>(
            () => MeController(apiRepository: Get.find()));
  }
}
