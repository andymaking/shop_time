import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../cache/network_config.dart';
import '../../cache/config.dart';

connect() {
  BaseOptions options = BaseOptions(
      baseUrl: Config.BASEURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(PrettyDioLogger());
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(options.uri.path);
        debugPrint(Config.BASEURL);
        debugPrint(options.data.toString());

        options.queryParameters = {
          "organization_id": NetworkConfig.ORGANIZATION_ID,
          "Apikey": NetworkConfig.API_KEY,
          "Appid": NetworkConfig.APP_ID,
        };
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        debugPrint("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {

        if(e.response == null){
          // showCustomToast("Connect Internet to proceed");
          return handler.next(e);
        }else if(!isJson(e.response?.data)){
          // showCustomToast("Error processing the request");
          return handler.next(e);
        }else {
          var box = GetStorage();
          debugPrint(e.response?.statusCode.toString());
          debugPrint(e.response?.data);
          debugPrint(e.response?.statusMessage);

          return handler.next(e);
        }
      },
    ),
  );

  return dio;
}

bool isJson(String str) {
  try {
    json.decode(str);
    return true;
  } catch (e) {
    return false;
  }
}