import 'dart:async';
import 'package:get/get_connect/http/src/response/response.dart';

import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';
import '../models/responses/banners_response.dart';
import '../models/responses/login_response.dart';
import '../models/responses/register_response.dart';
import '../models/responses/users_response.dart';
import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<LoginResponse?> login(LoginRequest data) async {
    var res = await apiProvider.login('/api/login', data);
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(res.body);
    }
  }

  Future<RegisterResponse?> register(RegisterRequest data) async {
    final res = await apiProvider.register('/api/register', data);
    if (res.statusCode == 200) {
      return RegisterResponse.fromJson(res.body);
    }
  }

  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }

  Future<BannersResponse?> getBanners() async {
    final res = await apiProvider.getUsers('/api/v1/banners');
    if (res.statusCode == 200) {
      return BannersResponse.fromJson(res.body);
    }
  }
  Future<LoginResponse?> hello() async {
    var res = await apiProvider.hello('/api/home');

  }
}