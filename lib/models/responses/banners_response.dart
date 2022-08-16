import 'package:billing/models/Product.dart';
import 'package:flutter/material.dart';

import '../../globals.dart' as globals;
import 'categories_response.dart';

class BannersResponse {
  BannersResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<DataBanners> data;

  BannersResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>DataBanners.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DataBanners {
  DataBanners({
    required this.id,
    this.title,
    required this.image,
  });
  late final int id;
  late final String? title;
  late final String image;
  late final String type;
    var target;
  DataBanners.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    type = json['type'];
    if(type==globals.type_category) {
      target = new Category.fromJson(json['target']);
    //  title =target.name;
    }
    else if(type ==globals.type_sub_category) {
      target = new Category.fromJson(json['target']);
      // title =target.title;
    }
    else if(type ==globals.type_product) {
      try {
        target = new Product.fromJson(json['target']);
      }
      catch(e)
    {

    }
     // title =target.title;
    }
    else if(type ==globals.type_external_url)
      target = json['target'] ;

    //if(title==null)
    title = json['title']??"";

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}