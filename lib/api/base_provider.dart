

import 'dart:io';

import 'package:dio/dio.dart';


import 'dart:async';
import 'api.dart';
/*
class BaseProvider extends GetConnect  {
  @override
  void onInit() {
    HttpOverrides.global = new MyHttpOverrides();
    httpClient.baseUrl = ApiConstants.baseUrl;

    httpClient.timeout = Duration(seconds: 18);
    httpClient.addAuthenticator(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}

 */
import 'package:get/get.dart';

import 'api.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = Duration(seconds: 18);
    httpClient.addAuthenticator(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
