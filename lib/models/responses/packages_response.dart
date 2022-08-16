class PackageResponse {
  PackageResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<PackageInner> data;

  PackageResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>PackageInner.fromJson(e)).toList();
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
class PackageInner {
  PackageInner({
    required this.id,
    required this.name,
    required this.months,
    required this.price,
    required this.numAdvs,
  });
  late final int id;
  late final String name;
  late final int months;
  late final int price;
  late final int numAdvs;

  late final int published_advs;
  late final int rest_advs;
   bool isExtra=false;
  PackageInner.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    months = json['months'];
    price = json['price'];
    numAdvs = json['num_advs'];
    if(json['published_advs']!=null)
      {
        published_advs= json['published_advs'];
      }
    if(json['rest_advs']!=null)
    {
      rest_advs= json['rest_advs'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['months'] = months;
    _data['price'] = price;
    _data['num_advs'] = numAdvs;
    return _data;
  }
}