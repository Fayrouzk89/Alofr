class SubCategoriesresponse {
  SubCategoriesresponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<SubCategory> data;

  SubCategoriesresponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'];
    data = List.from(json['data']).map((e)=>SubCategory.fromJson(e)).toList();
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

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
    required this.parent,
    required this.image,
  });
  late final int id;
  late final String name;
  late final Parent parent;
  late final String image;

  SubCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    parent = Parent.fromJson(json['parent']);
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['parent'] = parent.toJson();
    _data['image'] = image;
    return _data;
  }
}

class Parent {
  Parent({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;

  Parent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}