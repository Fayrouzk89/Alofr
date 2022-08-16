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
import '../../models/responses/banners_response.dart';
import '../../models/responses/company_response.dart';
import '../../models/responses/packages_response.dart';
import '../../models/responses/products_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/focus.dart';

class CompanyController extends GetxController {
  final ApiRepository apiRepository;
  List<Model> list = [];
  ScrollController controller = ScrollController();
  int listLength = 6;
  int _page = 1;
  CompanyController({required this.apiRepository});

  var banners = Rxn<BannersResponse>();
  Future<bool> getBanners() async {
    try {
      Api.setLoading('loading');
      final result = await ApiRepo().getCompanyBanners();

      if (result != null) {
        if (result!=null) {
          banners.value = result;
          banners.refresh();
          return true;
        } else {
          Log.loga(title, "getBanners:: e >>>>>");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getBanners:: e >>>>> $e");
      Api.hideLoading();
      return false;
    }
  }
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    loadData();
    addItems();
    super.onInit();

  }
  loadData()async
  {
    await getBanners();
    await getData(1);
  }
  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        _page = _page +1;
        getData(_page);
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

  var products = Rxn<CompanyResponse>();
  Future<CompanyResponse?> getData(int page) async {
    if(page==1) {
     //Api.setLoading('loading');
    }
    try {
      final result = await ApiRepo().getCompanyPage(page);
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
            products.value = result as CompanyResponse?;
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
