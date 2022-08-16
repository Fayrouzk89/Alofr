import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import '../../globals.dart' as globals;
FutureOr<Request> requestInterceptor(request) async {
   final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvM3phcHAuY29tXC9hcGlcL3YxXC9sb2dpbiIsImlhdCI6MTY1Mjc4MzY5MywibmJmIjoxNjUyNzgzNjkzLCJqdGkiOiJ5dmtQMWh0TkpSa0JuOFBqIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.NKG3OKHaoDsiQEVlR6HBow7bwCLRhfRUgAjk7kC8vuk";

  // request.headers['X-Requested-With'] = 'XMLHttpRequest';
   request.headers['Authorization'] = 'Bearer $token';
  request.headers['lang'] = globals.lang;
  EasyLoading.show(status: 'loading...');
  return request;
}