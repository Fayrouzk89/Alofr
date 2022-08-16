import 'package:billing/modules/Allproducts/products_controller.dart';
import 'package:get/get.dart';




class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
            () => ProductsController(apiRepository: Get.find(),categoryId: -1));
  }
}
