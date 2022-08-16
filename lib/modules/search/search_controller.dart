import 'dart:async';

import 'package:billing/models/responses/categories_response.dart';
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
import '../../models/responses/company_response.dart';
import '../../models/responses/products_response.dart';
import '../../models/responses/sub_catagories_response.dart';
import 'package:location/location.dart';
class SearchController extends GetxController {
  SubCategory? category;
  bool isNear=false;
  bool isLow=false;
  bool isHigh=false;
  String lat="";
  String long="";
  final ApiRepository apiRepository;
   String prefix;
  List<Model> list = [];
  ScrollController controller = ScrollController();
  int listLength = 6;
  int _page = 1;
  SearchController(this.prefix, {required this.apiRepository});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    initDefaults();
    getLatestProducts();
    getPopular();
    getData(1);
    // generateList();
    addItems();
    super.onInit();

  }
  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        _page = _page +1;
        getData(_page);
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
    initDefaults();
  }
  Future getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();
    if(_pos!=null) {
      lat = _pos.latitude.toString();
      long=_pos.longitude.toString();
    }

  }
  var products = Rxn<ProductResponse>();
  Future<ProductResponse?> getData(int page) async {
    if(page==1) {
      Api.setLoading('loading');
    }

    try {
      if(isNear==true)
        {
          await getLocation();
        }
      final result = await ApiRepo().getProductsByFilter(page,prefix,category,isNear, isHigh,lat,long);
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
        products.refresh();
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
  var latestProducts = Rxn<ProductResponse>();
  Future<bool> getLatestProducts() async {
    try {
      final result = await ApiRepo().getLatestSearches();
      if (result != null) {
        if (result!=null) {
          latestProducts.value = result;
          latestProducts.refresh();
          return true;
        } else {
          Log.loga(title, "getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getLatestProducts:: e >>>>> $e");
      return false;
    }
  }
  var popular = Rxn<ProductResponse>();
  Future<bool> getPopular() async {
    try {
      final result = await ApiRepo().getlatest_views();
      if (result != null) {
        if (result!=null) {
          popular.value = result;
          popular.refresh();
          return true;
        } else {
          Log.loga(title, "getPopular:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getPopular:: e >>>>> $e");
      return false;
    }
  }

  void initDefaults() {
    isNear=false;
    isLow=false;
    category=null;
    isHigh=false;
  }
}
