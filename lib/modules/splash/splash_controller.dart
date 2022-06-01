import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 3000));
    var storage = Get.find<SharedPreferences>();
    try {
      await LocalString.LoadLang();
      if (storage.getString(StorageConstants.lang) == null) {
        Get.toNamed(Routes.Lang);
      }
      else if (storage.getString(StorageConstants.token) != null) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.toNamed(Routes.AUTH);
    }
  }

}