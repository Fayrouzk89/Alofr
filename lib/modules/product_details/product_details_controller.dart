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
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class DetailsController extends GetxController {
  bool isNullByUser=false;
  bool isNullSimilar=false;
  final ApiRepository apiRepository;
  final Product? product;
  DetailsController({required this.apiRepository,required this.product});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    callMethods();

  }
  void callMethods()async
  {
     isNullByUser=false;
     isNullSimilar=false;
    Api.setLoading("Please wait");
   await getProductDetails(product);
    await getByUserId();
    await getSimilar();

    Api.hideLoading();
  }
  @override
  void onReady() {
    super.onReady();
  }

  var ByUser = Rxn<ProductResponse>();
  var Similar = Rxn<ProductResponse>();
  Future<ProductDetailsResponse?> getProductDetails(Product? product) async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getProductDetails(product!.id);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {

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

  Future<bool> getByUserId() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getProductsPageByUserId(1,product!.user.id);
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          ByUser.value = result;
          ByUser.refresh();
          return true;
        } else {
          isNullByUser=true;
          ByUser.refresh();
          Log.loga(title, "getPopular:: e >>>>> ");
          return false;
        }
      }
      else
        {
          isNullByUser=true;
          ByUser.refresh();
        }

      return false;
    } catch (e) {
      Log.loga(title, "getPopular:: e >>>>> $e");
      setLoading(false);
      isNullByUser=true;
      ByUser.refresh();
      return false;
    }
  }
  Future<bool> getSimilar() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getProductsPage(1,product!.category.id);
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          Similar.value = result;
          Similar.refresh();
          return true;
        } else {
          isNullSimilar=true;
          Similar.refresh();
          Log.loga(title, "getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      else
        {
          isNullSimilar=true;
          Similar.refresh();
        }
      return false;
    } catch (e) {
      isNullSimilar=true;
      Similar.refresh();
      Log.loga(title, "getLatestProducts:: e >>>>> $e");
      setLoading(false);
      return false;
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
