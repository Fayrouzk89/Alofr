import 'dart:async';
import 'dart:convert';

import 'package:billing/models/Product.dart';
import 'package:billing/models/responses/general_response.dart';
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
import '../../models/responses/packages_response.dart';
import '../../models/responses/products_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class MyAdsController extends GetxController {
  final ApiRepository apiRepository;
  final  int categoryId;
  List<Model> list = [];
  ScrollController controller = ScrollController();
  int listLength = 6;
  int page = 1;
  MyAdsController({required this.apiRepository,required this.categoryId});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    getProducts(1);
    // generateList();
    addItems();
    super.onInit();

  }
  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page = page+1;
        if(products!=null && products.value!=null && products.value!.meta.totalPages<page)
          {

          }
        else
        getProducts(page);
        /*
        for (int i = 0; i < 2; i++) {
          listLength++;
          list.add(Model(name: (listLength).toString()));
          update();
        }

         */
      }
    });
  }

  generateList() {
    list = List.generate(
        listLength, (index) => Model(name: (index + 1).toString()));
  }


  @override
  void onReady() {
    super.onReady();
  }
  bool isLoading=false;
  var products = Rxn<ProductResponse>();
  Future<ProductResponse?> getProducts(int page) async {
    isLoading=true;
    if(page==1) {
      Api.setLoading('loading');
    }
    try {
      final result = await ApiRepo().getProductsPage(page,categoryId);
      if(page==1) {
        Api.hideLoading();
      }
      isLoading=false;
      if (result != null) {
        if (result!=null) {

          if(page>1)
          {
            if(result.data!=null && result.data.length>0)
            {
              for(int i=0;i<result.data.length;i++)
              {
                products.value!.data.add(result.data[i]);
              }
              products.refresh();
            }
          }
          else {
            products.value = null;
            products.value = result as ProductResponse?;

            products.refresh();
          }
          //  update();
        } else {
          Log.loga(title, "getProducts:: e >>>>> ");
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "getProducts:: e >>>>> $e");
      if(page==1) {
        Api.hideLoading();
      }
      isLoading=false;
      return null;
    }
  }

  Future<GeneralResponse?> deleteProduct(BuildContext context,Product product) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().deleteProduct(product);
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
  void processRegisterResult(GeneralResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        MessageHelper.showMessage(context,LocalString.getStringValue(
            context, 'deleted_success') ??
            'تم الحذف بنجاح');
         getProducts(1);
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

  void processFailRegister(GeneralResponse response,BuildContext context)
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
}
