import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phincash/repository/cached_data.dart';
import '../../src/auth/login/login_views/login.dart';
import '../../utils/helpers/flushbar_helper.dart';
import 'dio_intercepter.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://phincash.yutechexpress.com',
            connectTimeout: 60000,
            receiveTimeout: 60000,
            sendTimeout: 60000,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
            LoggerInterceptor(),
          ]);

  late final Dio dio;

// HTTP request methods will go here
}

//
// // ignore: constant_identifier_names
// const String API_KEY = 'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae';

// Request methods PUT, POST, PATCH, DELETE needs access token,
// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  CachedData cachedData = CachedData();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await cachedData.getAuthToken();
    bool? csvStatus = await cachedData.getCsvUpLoadStatus();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    // if(csvStatus == true){
    //   options.headers["Content-Type"] = "multipart/form-data";
    // }else{
    options.headers["Content-Type"] = "application/json";
    // }
    options.headers["Accept"] = "application/json";
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await cachedData.cacheLoginStatus(isLoggedIn: false);
      Get.offAll(() => const Login());
      FlushBarHelper(Get.context!)
          .showFlushBar("Authentication Expired! Please Login",
              messageColor: Colors.red,
              icon: Icon(
                Icons.error_outline,
                size: 30,
                color: Colors.red,
              ),
              color: Colors.white,
              borderColor: Colors.red);
    }
    return handler.next(err);
  }

// bool _needAuthorizationHeader(RequestOptions options) {
  //   if (options.method == 'GET') {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
