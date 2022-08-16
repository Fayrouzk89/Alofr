import 'package:billing/modules/Allproducts/products_controller.dart';
import 'package:get/get.dart';

import 'company_controller.dart';




class CompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(
            () => CompanyController(apiRepository: Get.find()));
  }
}
