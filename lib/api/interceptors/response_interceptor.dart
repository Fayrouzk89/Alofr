import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../models/responses/error_response.dart';
import '../../shared/utils/common_widget.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  EasyLoading.dismiss();
  if (response.statusCode != 200) {
    handleErrorStatus(response);
  }

  return response;
}

void handleErrorStatus(Response response) {
  switch (response.statusCode) {
    case 400:
      final message = ErrorResponse.fromJson(response.body);
      CommonWidget.toast(message.error);
      break;
    default:
      final message = ErrorResponse.fromJson(response.body);
      CommonWidget.toast(message.error);
      break;
  }

  return ;
}