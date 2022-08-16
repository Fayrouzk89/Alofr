import '../Product.dart';

class ProductResponse {
  ProductResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<Product> data;
  late final Meta meta;


  int published_advs=0;
  int rest_advs=0;
  ProductResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'].toString();
    data = List.from(json['data']).map((e)=>Product.fromJson(e)).toList();
    if(json['meta']!=null)
      meta = Meta.fromJson(json['meta']);
    if(json["published_advs"]!=null)
    {
      published_advs=json["published_advs"];
      rest_advs=json["rest_advs"];
    }
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
class Meta {
  Meta({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });
  late final int total;
  late final int count;
  late final int perPage;
  late final int currentPage;
  late final int totalPages;

  Meta.fromJson(Map<String, dynamic> json){
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['count'] = count;
    _data['per_page'] = perPage;
    _data['current_page'] = currentPage;
    _data['total_pages'] = totalPages;
    return _data;
  }
}