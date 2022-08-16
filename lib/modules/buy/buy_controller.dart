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
import 'webview_payment.dart';
class BuyController extends GetxController {
  PackageInner? package;
  final ApiRepository apiRepository;
  int? numberAds=0;
  BuyController({required this.apiRepository});


  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    callGetAll();

  }
   callGetAll()async
   {
     await  getPackages();
     await getUserPackages();
     await getData();
   }
  @override
  void onReady() {
    super.onReady();
  }

  var packages = Rxn<PackageResponse>();
  var mypackages = Rxn<UserPackages>();
  Future<UserPackages?> getUserPackages() async {
    try {
      final result = await ApiRepo().getUserPackages();

      if (result != null) {
        if (result!=null) {
          if(result.package!=null) {
            mypackages.value=result;
            /*
            if(mypackages!=null && mypackages.value!.package!=null)
              {
                getExtraPackages();
              }
            else
              {
                getPackages();
              }

             */
          }
          mypackages.refresh();
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
  Future<PackageResponse?> getExtraPackages() async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getExtraPackages();
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          packages.value = result;
          for(int i=0;i<packages.value!.data.length;i++)
            {
              packages.value!.data[i].isExtra=true;
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

  Future<PackageResponse?> getPackages() async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getPackages();
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
  var data = Rxn<StaticPageResponse>();

  Future<StaticPageResponse?> getData() async {
    try {
      final result = await ApiRepo().getSettings();
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          data.value = result;
          globals.staticPageResponse=result;
          if(result.data!=null && result.data!.adv_price!=null)
            {
              globals.priceAdd = result.data!.adv_price!;
            }
          data.refresh();
         // update();
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
  Future<BuyResponse?> buyPackage(BuildContext context,PaymentMethods? card) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().buyPackage(package,card);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processUpdateResult(result,context);
          return result;
        } else {
          processUpdateResult(result,context);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processUpdateResult(null,context);
      return null;
    }
  }
  Future<BuyResponse?> buyAds(BuildContext context,PaymentMethods? card) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().buyAds(card,numberAds);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processUpdateResult(result,context);
          return result;
        } else {
          processUpdateResult(result,context);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processUpdateResult(null,context);
      return null;
    }
  }

  void processUpdateResult(BuyResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status==true)
      {
       globals.mainUrl = response.payUrl!;
       Get.to(new WebViewScreen());
      }
      else
      {
        MessageHelper.showMessage(context,response.message!);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  @override
  void onClose() {
    super.onClose();

  }
}
