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
import '../../models/responses/packages_response.dart';
import '../../models/responses/products_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class ProductsController extends GetxController {
  final ApiRepository apiRepository;
  final  int categoryId;
  List<Model> list = [];
  ScrollController controller = ScrollController();
  int listLength = 6;
  int _page = 1;
  ProductsController({required this.apiRepository,required this.categoryId});


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
        _page = _page +1;
        getProducts(++_page);
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

  var products = Rxn<ProductResponse>();
  Future<ProductResponse?> getProducts(int page) async {
    print("page id "+page.toString());
    if(page==1) {
      Api.setLoading('loading');
    }


    try {
      final result = await ApiRepo().getProductsPage(page,categoryId);
      if(page==1) {
        Api.hideLoading();
      }
      if (result != null) {
        if (result!=null) {
          if(_page>1)
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
      return null;
    }
  }

}
