import 'dart:io';

import 'package:billing/models/UserInfo.dart';
import 'package:billing/models/responses/general_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../dioApi/api.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/register_request.dart';
import '../../models/responses/login_response.dart';
import '../../models/responses/packages_response.dart';
import '../../models/responses/update_profile_response.dart';
import '../../models/responses/user_packages.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';
import '../../globals.dart' as globals;
class MeController extends GetxController {
  final ApiRepository apiRepository;
  MeController({required this.apiRepository});
  final FirstController = TextEditingController();
  final LastController = TextEditingController();
  final PhoneController = TextEditingController();
  final PasswordController = TextEditingController();
  String gender="";
  String individual="";
  File? imageFile;
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    getPackages();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var packages = Rxn<UserPackages>();
  Future<UserPackages?> getPackages() async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getUserPackages();
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          if(result.package!=null) {
           packages.value=result;
          }
          packages.refresh();
        } else {
          Log.loga(title, "getPackages:: e >>>>> ");
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "getPackages:: e >>>>> $e");
      Api.hideLoading();
      return null;
    }
  }
  void updateProfile(BuildContext context) async {
    AppFocus.unfocus(context);
    if (FormKey.currentState!.validate()) {

      // Get.toNamed(Routes.HOME);
      bool isEmptyPassword=false;
      if(PasswordController.text==null || PasswordController.text.length==0)
        {
          isEmptyPassword=true;
        }
      if(gender==null ||gender=="")
        {
          if(globals.userInfo!.gender=="0"||globals.userInfo!.gender=="female")
          gender = "female";
          else
            gender = "male";
        }
        if(individual==null || individual=="")
          {
            individual=globals.userInfo!.type;
          }
      UserInfo userInfo = UserInfo( id: 0,
          first_name: FirstController.text,
          second_name: LastController.text,
          gender: gender,
          mobile: PhoneController.text,
          password: PasswordController.text??"",
          password_confirmation: "",
          type:individual
      );
      userInfo.imageFile=imageFile;
      userInfo.isEmptyPassword=isEmptyPassword;
      UpdateUser(context,userInfo);
    }
  }
  Future<UpdateProfileResponse?> UpdateUser(BuildContext context,UserInfo userInfo) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().updateUser(userInfo);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processUpdateResult(result, context,userInfo);
          return result;
        } else {
          processUpdateResult(result, context,userInfo);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processUpdateResult(null, context,userInfo);
      return null;
    }
  }
  void processUpdateResult(UpdateProfileResponse? response,BuildContext context,UserInfo userInfo)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(globals.userInfo!.mobile==userInfo.mobile && response.data!=null) {
          StorageService.updateUserInfo(response.data!);
          MessageHelper.showMessage(context,LocalString.getStringValue(
              context, 'information_updated') ??
              'تم تحديث المعلومات بنجاح');
        }
        else
        {
          processFailLogin(response,context,userInfo);
        }
      }
      else
      {
        processFailLogin(response,context,userInfo);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processFailLogin(UpdateProfileResponse response,BuildContext context,UserInfo userInfo)
  {
    if(response.message!=null)
    {
      if(response.code=="433")
      {
        MessageHelper.showMessage(context,LocalString.getStringValue(
            context, 'number_updated') ??
            'لقد قمت بتغيير الرقم يجب تفعيل الحساب');
        StorageService.ResetInfo();
        MessageHelper.goToLogin(context);
      //  Get.toNamed(Routes.AUTH);
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


  @override
  void onClose() {
    super.onClose();

  }

}
