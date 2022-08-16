import 'package:billing/models/NotificationModel.dart';

import '../Company.dart';

class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final List<NotificationModel> data;

  NotificationResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'];
    if(json['data']!=null)
      data = List.from(json['data']).map((e)=>NotificationModel.fromJson(e)).toList();
    else
      {
        data=[];
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

