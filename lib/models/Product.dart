import 'package:billing/models/responses/categories_response.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'Images.dart';
import 'ProductCateogry.dart';
import 'ProductUser.dart';

class Product {
  Product({
    required this.id,
    required this.title,
    required this.desctiption,
    required this.price,
    required this.category,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.mobile,
    required this.images,
    required this.status,
    required this.views,
    required this.user,
    required this.createdAt,
  });
  late final int id;
  late final String title;
  late final String desctiption;
  late final String price;
  late final ProductCategory category;
  late final String city;
  late final String latitude;
  late final String longitude;
  late final String mobile;
  late final List<Images> images;
  late final String status;
  late final int views;
  late final String createdAt;
  late final ProductUser user;
   String note="";
  List<Asset> resultList = [];
  int categorymainId=0;
  int subcategoryId=0;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title']??"";
    desctiption =json['description']??"";
    price = json['price'].toString();
    category = ProductCategory.fromJson(json['category']);
    city = json['city']??"";
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    mobile = json['mobile'].toString();
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    status = json['status'].toString()??"";
    views = json['views'];
    createdAt = json['created_at'];
    user = ProductUser.fromJson(json['user']);
    if(json['notes']!=null)
    {
      note =json['notes'];
    }

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['desctiption'] = desctiption;
    _data['price'] = price;
    _data['category'] = category.toJson();
    _data['city'] = city;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['mobile'] = mobile;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['views'] = views;
    _data['created_at'] = createdAt;
    _data['user'] = user.toJson();
    return _data;
  }
}
