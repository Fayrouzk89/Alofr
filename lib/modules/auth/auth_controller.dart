import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/register_request.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerFirstController = TextEditingController();
  final registerLastController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  String gender="";
  String individual="";
  bool registerTermsChecked = false;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginStaffController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final forgetPhoneController = TextEditingController();

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String code="";


  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController newPasswordConfirmPasswordController = TextEditingController();
  //StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();

  //TextEditingController textEditingController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      Get.toNamed(Routes.HOME);
      /*
      if (!registerTermsChecked) {
        CommonWidget.toast('Please check the terms first.');
        return;
      }

      final res = await apiRepository.register(
        RegisterRequest(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );

      final prefs = Get.find<SharedPreferences>();
      if (res!.token.isNotEmpty) {
        prefs.setString(StorageConstants.token, res.token);
        print('Go to Home screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      }

       */
    }
  }


  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      Get.toNamed(Routes.HOME);
      /*
     var res =  await apiRepository.login(
        LoginRequest(
          staff: loginStaffController.text,
          password: loginPasswordController.text,
        ),
      );
      final prefs = Get.find<SharedPreferences>();
      if (res!.token.isNotEmpty) {
        prefs.setString(StorageConstants.token, res.token);
        Get.toNamed(Routes.HOME);
      }

       */
    }
  }
  void reset(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (forgetFormKey.currentState!.validate()) {
      Get.toNamed(Routes.AUTH + Routes.Reset,arguments: controller);
    }
  }
  void newPassword(BuildContext context,AuthController controller) async {
  AppFocus.unfocus(context);
  if (newPasswordFormKey.currentState!.validate()) {
  Get.toNamed(Routes.HOME);
  }
  }
  void enterCode(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (passwordFormKey.currentState!.validate()) {
      if (code=='' || code.length<4) {
        CommonWidget.toast(LocalString.getStringValue(context, 'please_enter_code') ??
            "يجب ادخال كود التحقق");
        return;
      }
      Get.toNamed(Routes.AUTH + Routes.NewPassword,arguments: controller);
    }
  }

  @override
  void onClose() {
    super.onClose();

    registerFirstController.dispose();
    registerLastController.dispose();
    registerPhoneController.dispose();
    registerConfirmPasswordController.dispose();
    registerPasswordController.dispose();
     gender="";
     individual="";
    loginStaffController.dispose();
    loginPasswordController.dispose();
    code="";
  //  newPasswordFormKey.dispose();
    newPasswordEditingController.dispose();
    newPasswordConfirmPasswordController.dispose();
    //textEditingController.dispose();
    focusNode.dispose();


  }
}
