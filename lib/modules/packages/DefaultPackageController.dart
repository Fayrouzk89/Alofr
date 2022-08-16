import 'dart:convert';

import 'package:billing/models/responses/general_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../dioApi/api.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/Product.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/register_request.dart';
import '../../models/responses/add_product_response.dart';
import '../../models/responses/buy_response.dart';
import '../../models/responses/packages_response.dart';
import '../../models/responses/static_page_response.dart';
import '../../models/responses/user_packages.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';
import '../../globals.dart' as globals;

class DefaultPackageController extends GetxController {
  PackageInner? package;
  final ApiRepository apiRepository;
  int? numberAds=0;
  DefaultPackageController({required this.apiRepository});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    callGetAll();

  }
  callGetAll()async
  {
    await  getPackages();
   // await getUserPackages();
   // await getData();
  }
  @override
  void onReady() {
    super.onReady();
  }

  var packages = Rxn<PackageResponse>();


  Future<PackageResponse?> getPackages() async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getPackages();
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          packages.value = result;
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




  @override
  void onClose() {
    super.onClose();

  }
}
