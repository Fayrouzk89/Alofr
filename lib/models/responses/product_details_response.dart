import '../Product.dart';

class ProductDetailsResponse {
  ProductDetailsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final Product data;

  ProductDetailsResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if(json['data']!=null)
    data = Product.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

