import 'dart:async';
import 'dart:convert';

import 'package:billing/models/UserInfo.dart';
import 'package:billing/models/responses/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../dioApi/api.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/register_request.dart';
import '../../models/responses/create_account_response.dart';
import '../../models/responses/general_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';
import '../../globals.dart' as globals;
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

   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginStaffController = TextEditingController();
  final loginPasswordController = TextEditingController();

   GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final forgetPhoneController = TextEditingController();

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController newTextEditingController = TextEditingController();


  final GlobalKey<FormState> activateFormKey = GlobalKey<FormState>();
  String codeActivation="";

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

     // Get.toNamed(Routes.HOME);
      UserInfo userInfo = UserInfo( id: 0,
         first_name: registerFirstController.text,
         second_name: registerLastController.text,
         gender: gender,
         mobile: registerPhoneController.text,
         password: registerPasswordController.text,
         password_confirmation: registerConfirmPasswordController.text,
         type:individual
      );
      globals.userInfo=userInfo;
      RegisterUser(context,userInfo);
    }
  }
  Future<CreateAccountResponse?> RegisterUser(BuildContext context,UserInfo userInfo) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().registerUser(userInfo);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processRegisterResult(result, context);
          return result;
        } else {
          processRegisterResult(result, context);
        }
      }
      else
        {
          return null;
        }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processRegisterResult(null, context);
      return null;
    }
  }

  Future<LoginResponse?> login(BuildContext context,UserInfo userInfo) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      String deviceType= await StorageService.getDevice(context);
      userInfo.deviceType=deviceType;
      try {
        final result = await ApiRepo().validateUser(userInfo);
        Api.hideLoading();
        if (result!=null) {
          processResult(result, context);
          return result;
        } else {
          processResult(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        processResult(null, context);
      }
    }
  }
  void processResult(LoginResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(response.data!=null && response.data.user!=null) {
          StorageService.saveUserInfo(response.data.user);
         // Get.clearRouteTree();
         // Get.offNamedUntil(Routes.HOME', (route) => false);;
          if(Get.previousRoute==Routes.HOME)
            {
              Get.back();
            }
          else {
            Get.toNamed(Routes.HOME);
          }
        }
        else
        {
          processFailLogin(response,context);
        }
      }
      else
      {
        processFailLogin(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processRegisterResult(CreateAccountResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(response.data!=null && response.data!=null) {
          MessageHelper.showMessage(context,response.message!);
          globals.activateMsg=response.message!;
          Get.toNamed(Routes.AUTH + Routes.activate,
              arguments: this);
        }
        else
        {
          processFailRegister(response,context);
        }
      }
      else
      {
        processFailRegister(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  void processFailRegister(CreateAccountResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_register') ??
          'خطأ في التسجيل يرجى التحقق من المعلومات');
    }
  }
  void processFailLogin(LoginResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      if(response.code==Api.code_activate)
        {
          globals.activateMsg=response.message!;
          Get.toNamed(Routes.AUTH + Routes.activate,
              arguments: this);
        }
      else
      MessageHelper.showMessage(context,response.message);
    }
    else
      {
        MessageHelper.showMessage(context,LocalString.getStringValue(
            context, 'error_login') ??
            'خطأ في تسجيل الدخول يرجى التحقق من المعلومات');
      }
  }
  void forget(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (forgetFormKey.currentState!.validate()) {
      UserInfo userInfo = UserInfo( id: 0,
          first_name: "",
          second_name:"",
          gender: "",
          mobile: forgetPhoneController.text,
          password: "",
          password_confirmation: "",
          type:""
      );
      globals.userInfo=userInfo;
      forgetCall(context,1);

    }
  }
  Future<GeneralResponse?> forgetCall(BuildContext context,int id) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      try {
        final result = await ApiRepo().forget_password(userInfo!);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcessForget(result, context,id);
          return result;
        } else {
          GeneralResponseProcessForget(result, context,id);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcessForget(null, context,id);
      }
    }
  }
  void GeneralResponseProcessForget(GeneralResponse? response,BuildContext context,int id)
  {
    if(response!=null)
    {
      if(response.status)
      {
         if(id==1) {
             globals.activateMsg= response.message??"";
           Get.toNamed(Routes.AUTH + Routes.Reset, arguments: this);
         }
         else
           {
             MessageHelper.showMessage(context,response.message);
           }
         //else
         //  Get.toNamed(Routes.AUTH + Routes.LOGIN,arguments: this);
      }
      else
      {
        processFailForget(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  void newPassword(BuildContext context,AuthController controller) async {
  AppFocus.unfocus(context);
    if (newPasswordFormKey.currentState!.validate()) {
      UserInfo userInfo = UserInfo( id: 0,
          first_name:"",
          second_name: "",
          gender: "",
          mobile: globals.userInfo!.mobile,
          password: newPasswordEditingController.text,
          password_confirmation: newPasswordConfirmPasswordController.text,
          type:''
      );
      userInfo.otp_code=code;
      globals.userInfo=userInfo;
      newPasswordCall(context,userInfo);

      }
  }
  Future<GeneralResponse?> newPasswordCall(BuildContext context,UserInfo? userInfo) async {
    if(userInfo!=null) {

      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      try {
        final result = await ApiRepo().resetUser(userInfo);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcess(result, context);
          return result;
        } else {
          GeneralResponseProcess(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcess(null, context);
      }
    }
  }
  void enterCode(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (activateFormKey.currentState!.validate()) {
      if (codeActivation=='' || codeActivation.length<5) {
        CommonWidget.toast(LocalString.getStringValue(context, 'please_enter_code') ??
            "يجب ادخال كود التحقق");
        return;
      }
      verifyAccount(context,codeActivation);
    }
  }
  void resendCode(BuildContext context,AuthController controller) async {
      if(globals.userInfo!=null) {
        UserInfo? userInfo = globals.userInfo;
        Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
            'يرجى الانتظار');
        //AppFocus.unfocus(context);
          forgetCall(context,2);


      }
  }
  void enterResetCode(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (passwordFormKey.currentState!.validate()) {
      if (code=='' || code.length<5) {
        CommonWidget.toast(LocalString.getStringValue(context, 'please_enter_code') ??
            "يجب ادخال كود التحقق");
        return;
      }
      Get.toNamed(Routes.AUTH + Routes.NewPassword,
          arguments: this);
    }
  }

  Future<GeneralResponse?> resetAccount(BuildContext context,String code) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      userInfo!.otp_code = code;
      try {
        final result = await ApiRepo().forget_password(userInfo);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcess(result, context);
          return result;
        } else {
          GeneralResponseProcess(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcess(null, context);
      }
    }
  }
  Future<GeneralResponse?> verifyAccount(BuildContext context,String code) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      userInfo!.otp_code = code;
      try {
        final result = await ApiRepo().verifyUser(userInfo);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcess(result, context);
          return result;
        } else {
          GeneralResponseProcess(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcess(null, context);
      }
    }
  }
  void GeneralResponseProcess(GeneralResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        loginFormKey=GlobalKey<FormState>();
          Get.toNamed(Routes.AUTH + Routes.LOGIN,
              arguments: this);
      }
      else
      {
        processFailActiate(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  void processFailActiate(GeneralResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
        MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_activate') ??
          'خطأ في كود التفعيل يرجى التحقق من المعلومات');
    }
  }
  void processFailForget(GeneralResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_forget') ??
          'خطأ في العملية  يرجى التحقق من المعلومات');
    }
  }

  @override
  void onClose() {
    super.onClose();
    globals.userInfo=null;
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
    codeActivation="";
  //  newPasswordFormKey.dispose();
    newPasswordEditingController.dispose();
    newPasswordConfirmPasswordController.dispose();
    //textEditingController.dispose();
    focusNode.dispose();


  }
}
