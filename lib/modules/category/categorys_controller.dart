import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../dioApi/api.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/Model.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/register_request.dart';
import '../../models/responses/categories_response.dart';
import '../../models/responses/packages_response.dart';
import '../../models/responses/products_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class CategorysController extends GetxController {
  final ApiRepository apiRepository;
  final int mainCategoryId;
  List<Model> list = [];
  ScrollController controller = ScrollController();
  int listLength = 6;
  int _page = 1;
  CategorysController({required this.apiRepository,required this.mainCategoryId});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    //getCategories(mainCategoryId);
    super.onInit();

  }




  @override
  void onReady() {
    super.onReady();
  }

  var categories = Rxn<CategoryMainResponse>();
  Future<CategoryMainResponse?> getCategories(int categoryId) async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getSubCategoriesByParent(categoryId);
      Api.hideLoading();
      if (result!=null) {
        categories.value =result;
        categories.refresh();
        return result;
      } else {
        Log.loga(title, "getSubCategoriesByParent:: e >>>>> ");
      }
      return null;
    } catch (e) {
      Log.loga(title, "getSubCategoriesByParent:: e >>>>> $e");
      Api.hideLoading();
      return null;
    }
  }

}
