import 'package:get/get.dart';

import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';
import 'base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());

  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }
  Future<Response> hello(String path) {
    return post(path,"");
  }

}