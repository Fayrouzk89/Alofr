import 'package:billing/modules/notifications/notifications_controller.dart';
import 'package:billing/modules/search/search_controller.dart';
import 'package:get/get.dart';





class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
            () => NotificationController( apiRepository: Get.find()));
  }
}
