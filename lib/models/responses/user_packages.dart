import 'package:billing/models/responses/packages_response.dart';

import '../Package.dart';
import '../PackageInnerCustom.dart';

class UserPackages {
  UserPackages({
    required this.package,
  });
    PackageInnerCustom? package;
  late final int publishedAdvs;
  late final int restAdvs;
  UserPackages.fromJson(Map<String, dynamic> json){
    if(json['package']!=null)
    package = PackageInnerCustom.fromJson(json['package']);
    if(json['published_advs']!=null)
    publishedAdvs = json['published_advs'];
    if(json['rest_advs']!=null)
    restAdvs = json['rest_advs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['package'] = package!.toJson();
    return _data;
  }
}