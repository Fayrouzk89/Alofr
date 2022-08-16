import '../Company.dart';

class CompanyResponse {
  CompanyResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<Company> data;

  CompanyResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'];
    if(json['data']!=null)
    data = List.from(json['data']).map((e)=>Company.fromJson(e)).toList();
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

