import 'package:billing/models/responses/banners_response.dart';

class CategoryMainResponse {
  CategoryMainResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<Category> data;

  CategoryMainResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString()??"";
    message = json['message'].toString()??"";
    if(json['data']!=null)
    data = List.from(json['data']).map((e)=>Category.fromJson(e)).toList();
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

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;
  List<DataBanners>? banners;


  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name']??"";
    image = json['image']??"";
    if (json['banners'] != null) {
      banners = <DataBanners>[];
      json['banners'].forEach((v) {
        banners!.add(new DataBanners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}
