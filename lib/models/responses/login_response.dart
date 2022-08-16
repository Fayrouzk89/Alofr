import 'dart:convert';

import '../Package.dart';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final DataUserLogin data;

  LoginResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code']??"";
    message = json['message']??"";
    if(json['data']!=null)
    data = DataUserLogin.fromJson(json['data']);
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

class DataUserLogin {
  DataUserLogin({
    required this.user,
  });
  late final User user;

  DataUserLogin.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.gender,
    required this.type,
    required this.mobile,
    required this.photoProfile,
    required this.deviceType,
    required this.fcmToken,
    required this.accessToken,
    required this.package,
    required this.numAdvs,
  });
  late final int id;
  late final String first_name;
  late final String last_name;
  late final String gender;
  late final String type;
  late final String mobile;
  late final String photoProfile;
  late final String deviceType;
  late final String fcmToken;
  late final String accessToken;
  late final Package package;
  late final int numAdvs;

  User.fromJson(Map<String, dynamic> json){
    if(json['id']!=null)
    id = json['id'];
    else
      id=0;
    first_name = json['first_name']??"";
    last_name = json['last_name']??"";
    gender = json['gender'].toString()??"";
    type = json['type']??"";
    mobile = json['mobile'];
    photoProfile = json['photo_profile'];
    deviceType = json['device_type']??"";
    fcmToken = json['fcm_token']??"";
    accessToken = json['access_token']??"";
    if(json['package']!=null)
    package = Package.fromJson(json['package']);
    numAdvs = json['num_advs']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = first_name;
    _data['last_name'] = last_name;
    _data['gender'] = gender;
    _data['type'] = type;
    _data['mobile'] = mobile;
    _data['photo_profile'] = photoProfile;
    _data['device_type'] = deviceType;
    _data['fcm_token'] = fcmToken;
    _data['access_token'] = accessToken;
    _data['package'] = package.toJson();
    _data['num_advs'] = numAdvs;
    return _data;
  }
}

