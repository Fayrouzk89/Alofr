import 'package:billing/modules/StatisticPage/statistic_controller.dart';
import 'package:get/get.dart';





class StatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatController>(
            () => StatController(apiRepository: Get.find()));
  }
}
