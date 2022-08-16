import 'package:billing/modules/Allproducts/products_controller.dart';
import 'package:get/get.dart';

import 'categorys_controller.dart';




class CategorysBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorysController>(
            () => CategorysController(apiRepository: Get.find(), mainCategoryId: 0));
  }
}
