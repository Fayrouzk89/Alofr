import 'dart:async';
import 'package:billing/models/responses/general_response.dart';
import 'package:billing/models/responses/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_repository.dart';
import '../../dioApi/api.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/Model.dart';
import '../../models/responses/company_response.dart';

class NotificationController extends GetxController {
  final ApiRepository apiRepository;
  List<Model> list = [];
  NotificationController({required this.apiRepository});

  ScrollController controller = ScrollController();
  int listLength = 6;
  int _page = 1;
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  void onInit() {
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

  var data = Rxn<NotificationResponse>();
  Future<NotificationResponse?> getData(int page) async {

    Api.setLoading('loading');
    try {
      final result = await ApiRepo().getNotificationList(page);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          if(_page>1)
          {
            if(result.data!=null && result.data.length>0)
            {
              for(int i=0;i<result.data.length;i++)
              {
                data.value!.data.add(result.data[i]);
              }
              data.refresh();
            }
          }
          else {
            data.value = result as NotificationResponse?;
            data.refresh();
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
      Api.hideLoading();
      return null;
    }
  }



}
