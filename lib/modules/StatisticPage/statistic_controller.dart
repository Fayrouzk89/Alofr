import 'dart:convert';

import 'package:billing/models/Product.dart';
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
import '../../models/responses/packages_response.dart';
import '../../models/responses/product_details_response.dart';
import '../../models/responses/product_details_response.dart';
import '../../models/responses/products_response.dart';
import '../../models/responses/static_page_response.dart';
import '../../globals.dart' as globals;
class StatController extends GetxController {
  final ApiRepository apiRepository;
  StatController({required this.apiRepository});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    callMethods();

  }
  void callMethods()async
  {
    if(globals.staticPageResponse==null) {
      Api.setLoading("Please wait");
      getData();
      Api.hideLoading();
    }
    else
      {
        data.value = globals.staticPageResponse;
        data.refresh();
        update();
      }
  }
  @override
  void onReady() {
    super.onReady();
  }

  var data = Rxn<StaticPageResponse>();

  Future<StaticPageResponse?> getData() async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getSettings();
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          data.value = result;
          globals.staticPageResponse=result;
          data.refresh();
          update();
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

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void setLoading(bool show) {
    _isLoading.value = show;
  }
  @override
  void onClose() {
    super.onClose();

  }
}
