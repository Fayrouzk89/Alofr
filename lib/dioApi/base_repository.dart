import 'package:dio/dio.dart';

import 'api_params.dart';
import 'api_utils.dart';


class BaseRepo<T> {
  Future<T> get({
    required String apiURL,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {


    try {
      final response = await apiUtils.get(
        url: apiURL,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      return {
        PARAM_STATUS_CODE: CODE_ERROR,
        PARAM_MESSAGE: apiUtils.handleError(e),
      } as T;
    }
  }

  Future<T> post({
    required String apiURL,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await apiUtils.post(
        url: apiURL,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      return {
        PARAM_STATUS_CODE: CODE_ERROR,
        PARAM_MESSAGE: apiUtils.handleError(e),
      } as T;
    }
  }
}