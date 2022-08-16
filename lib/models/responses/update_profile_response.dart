import '../Package.dart';

class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final UpdateProfile? data;

  UpdateProfileResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'];
    if(json['data']!=null) {
      data = UpdateProfile.fromJson(json['data']);
    }
    else
      data=null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;

    return _data;
  }
}

class UpdateProfile {
  UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.gender,
    required this.type,
    required this.photoProfile,
    this.package,
    required this.numAdvs,
  });
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String gender;
  late final String type;
  late final String photoProfile;
  late final Package? package;
  late final int numAdvs;

  UpdateProfile.fromJson(Map<String, dynamic> json){
    firstName = json['first_name']??"";
    lastName = json['last_name']??"";
    mobile = json['mobile']??"";
    gender = json['gender']??"";
    type = json['type']??"";
    photoProfile = json['photo_profile']??"";
    if(json['package']!=null)
      package = Package.fromJson(json['package']);
    else
      package=null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['mobile'] = mobile;
    _data['gender'] = gender;
    _data['type'] = type;
    _data['photo_profile'] = photoProfile;
    _data['package'] = package;
    _data['num_advs'] = numAdvs;
    return _data;
  }
}