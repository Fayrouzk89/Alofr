import 'Package.dart';

class ProductUser {
  ProductUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.gender,
    required this.type,
    required this.photoProfile,
    this.deviceType,
    this.fcmToken,
    this.package,
    required this.numAdvs,
  });

  late final int id;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String gender;
  late final String type;
  late final String photoProfile;
  late final String? deviceType;
  late final String? fcmToken;
  late final Package? package;
  late final int numAdvs;

  ProductUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    gender = json['gender'];
    type = json['type'];
    photoProfile = json['photo_profile'];
    deviceType = null;
    fcmToken = null;
    package = null;
    numAdvs = json['num_advs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['mobile'] = mobile;
    _data['gender'] = gender;
    _data['type'] = type;
    _data['photo_profile'] = photoProfile;
    _data['device_type'] = deviceType;
    _data['fcm_token'] = fcmToken;
    _data['package'] = package;
    _data['num_advs'] = numAdvs;
    return _data;
  }
}
