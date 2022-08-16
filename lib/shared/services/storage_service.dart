import 'dart:io';

import 'package:billing/models/UserInfo.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/responses/login_response.dart';
import '../../models/responses/update_profile_response.dart';
import '../constants/storage.dart';
import '../../globals.dart' as globals;
class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return SharedPreferences.getInstance();
  }
 static Future<bool> saveLang(String lang) async {
    globals.lang=lang;
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.lang, lang);
    prefs.commit();
    return true;
  }
  static Future<bool> SaveFCM(String fcm) async {
    globals.fcm=fcm;
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.fcmFireBase, fcm);
    prefs.commit();
    return true;
  }

  static Future<bool> saveUserInfo(User user) async {

    var prefs = Get.find<SharedPreferences>();
    prefs.setInt(StorageConstants.id, user.id);
    prefs.setString(StorageConstants.mobile, user.mobile??"");
    prefs.setString(StorageConstants.first_name, user.first_name);
    prefs.setString(StorageConstants.last_name, user.last_name);
    prefs.setString(StorageConstants.gender, user.gender);
    prefs.setString(StorageConstants.type, user.type);
    prefs.setString(StorageConstants.fcmToken, user.fcmToken??"");
    prefs.setString(StorageConstants.accessToken, user.accessToken);
    prefs.setString(StorageConstants.deviceType, user.deviceType??"");
    prefs.setInt(StorageConstants.numAdvs, user.numAdvs??0);
    prefs.setString(StorageConstants.photo_profile, user.photoProfile??"");
    prefs.commit();
    LoadUser();
    return true;
  }
  static Future<bool> updateUserInfo(UpdateProfile user) async {

    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.mobile, user.mobile);
    prefs.setString(StorageConstants.first_name, user.firstName);
    prefs.setString(StorageConstants.last_name, user.lastName);
    prefs.setString(StorageConstants.gender, user.gender);
    prefs.setString(StorageConstants.type, user.type);
    prefs.setString(StorageConstants.photo_profile, user.photoProfile);
    prefs.commit();
    await LoadUser();
    return true;
  }

  static Future<String> getDevice(BuildContext context) async {
    String res = "";
    try
    {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        res = build.brand; // reset when device factory reset.
      }
      else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        res = data.model;
      }
    }
    catch(e) {
      String err = e.toString();
    }
    return res;
  }
  static Future<bool> LoadToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    globals.fcm = sharedPreferences.getString(StorageConstants.fcmFireBase) ?? '';
    return true;
  }
  static Future<bool> LoadUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    globals.lang = sharedPreferences.getString('lang') ?? '';
    globals.fcm = sharedPreferences.getString(StorageConstants.fcmFireBase) ?? '';
    int id = sharedPreferences.getInt(StorageConstants.id) ?? -1;

    String first_name = sharedPreferences.getString(
        StorageConstants.first_name) ??
        "";
    String second_name = sharedPreferences.getString(
        StorageConstants.last_name) ??
        "";
    String gender = sharedPreferences.getString(StorageConstants.gender) ??
        "";
    String type = sharedPreferences.getString(StorageConstants.type) ??
        "";
    String photo = sharedPreferences.getString(
        StorageConstants.photo_profile) ??
        "";
    //TO DO
    String mobile = sharedPreferences.getString(StorageConstants.mobile) ?? "";
    String fcmToken = sharedPreferences.getString(StorageConstants.fcmToken) ??
        "";
    String accessToken = sharedPreferences.getString(
        StorageConstants.accessToken) ?? "";
    String deviceType = sharedPreferences.getString(
        StorageConstants.deviceType) ?? "";
    int numAdvs = sharedPreferences.getInt(StorageConstants.numAdvs) ?? 0;
    UserInfo userInfo = UserInfo(id: id,
        first_name: first_name,
        second_name: second_name,
        mobile: mobile,
        password: "",
        password_confirmation: "",
        gender: gender,
        type: type);
    userInfo.accessToken=accessToken;
    userInfo.fcmToken=fcmToken;
    userInfo.profile = photo;
    if (id == -1)
    {
      globals.userInfo=null;
    }
    else
    globals.userInfo=userInfo;
    return true;
  }
  static void SignOutUser() {
    ResetInfo();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
  static void ResetInfo() {
    var prefs = Get.find<SharedPreferences>();
    prefs.setInt(StorageConstants.id, -1);
    prefs.setString(StorageConstants.mobile, "");
    prefs.setString(StorageConstants.first_name, "");
    prefs.setString(StorageConstants.last_name, "");
    prefs.setString(StorageConstants.gender,"");
    prefs.setString(StorageConstants.type, "");
    prefs.setString(StorageConstants.fcmToken, "");
    prefs.setString(StorageConstants.accessToken,"");
    prefs.setString(StorageConstants.deviceType, "");
    prefs.setInt(StorageConstants.numAdvs, 0);
    prefs.setString(StorageConstants.photo_profile, "");
    prefs.commit();
    globals.userInfo=null;

  }

}