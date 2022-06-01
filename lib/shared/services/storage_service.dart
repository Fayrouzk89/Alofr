import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage.dart';
import '../../globals.dart' as globals;
class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
 static Future<bool> saveLang(String lang) async {
    globals.lang=lang;
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.lang, lang);
    prefs.commit();
    return true;
  }

}