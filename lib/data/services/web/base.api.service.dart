import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../cache/constants.dart';
import '../../model/default.model.dart';
import '../../cache/config.dart';
import '../../cache/database-keys.dart';

String? newToken;


connect({bool? useFormData}) {
  BaseOptions options = BaseOptions(
      baseUrl: Config.BASEURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(PrettyDioLogger());
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(options.uri.path);
        debugPrint(Config.BASEURL);
        debugPrint(options.data.toString());
        
        String? value = await  storageService.read(key: StorageKey.TOKEN_TABLE_NAME);
        debugPrint("ACCESS TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Bearer $value";
          if(useFormData == true){
            options.headers['Accept'] = "multipart/form-data";
            options.headers['Content-Type'] = "multipart/form-data";
          }
        }
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

          try{
            if(ResModel.fromJson(jsonDecode(e.response?.data)).message == "Malformed or expired token provided"){
              bool hasKey = box.hasData(StorageKey.REFRESH_TOKEN_TABLE_NAME);
              if (hasKey) {
                bool value = await refreshAuthToken();
                print("DID IT REFRESH TOKEN === $value");
                if (value) {
                  return handler.resolve(await _retry(e.requestOptions));
                }else{
                  await userService.logout();
                }
              }else{
                await userService.logout();
              }
            }else{
              return handler.next(e);
            }
          }catch(err){
            return handler.next(e);
          }

          return handler.next(e);
        }
      },
    ),
  );

  return dio;
}


privateConnect({bool? useFormData}) {
  BaseOptions options = BaseOptions(
      baseUrl: Config.BASEURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // debugPrint(options.uri.path);
        // debugPrint(Config.BASEURL);
        // debugPrint(options.data.toString());
        
        String? value = await storageService.read(key: StorageKey.TOKEN_TABLE_NAME);
        // debugPrint("ACCESS TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Bearer $value";
          if(useFormData == true){
            options.headers['Accept'] = "multipart/form-data";
            options.headers['Content-Type'] = "multipart/form-data";
          }
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // debugPrint("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {

        var box = GetStorage();

        if(e.response == null){
          // showCustomToast("Connect Internet to proceed");
          return handler.next(e);
        }else if(!isJson(e.response?.data)){
          // showCustomToast("Error processing the request");
          return handler.next(e);
        }else {
          try{
            if(ResModel.fromJson(jsonDecode(e.response?.data)).message == "Malformed or expired token provided"){
              bool hasKey = box.hasData(StorageKey.REFRESH_TOKEN_TABLE_NAME);
              if (hasKey) {
                bool value = await refreshAuthToken();
                print("DID IT REFRESH TOKEN === $value");
                if (value) {
                  return handler.resolve(await _retry(e.requestOptions));
                }else{
                  await userService.logout();
                }
              }else{
                await userService.logout();
              }
            }else{
              return handler.next(e);
            }
          }catch(err){
            return handler.next(e);
          }

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


Future _retry(RequestOptions requestOptions) async {

  final options = Options(
      method: requestOptions.method,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $newToken'});

  return connect().request(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options);
}

refresh() {
  BaseOptions options = BaseOptions(
      baseUrl: Config.BASEURL,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(options.uri.path);
        debugPrint(options.data.toString());

        String? value = await storageService.read(key: StorageKey.REFRESH_TOKEN_TABLE_NAME);
        debugPrint("REFRESH TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.headers['x-refresh-token'] = value;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        print("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        debugPrint(e.response?.statusCode.toString());
        debugPrint(e.response?.data.toString());
        debugPrint(e.response?.statusMessage);

        if(e.response!.statusMessage.toString().toUpperCase().contains("unauthorized")){
          await userService.logout();
        }

        return handler.next(e);
      },
    ),
  );

  return dio;
}

Future<bool> refreshAuthToken() async {
  try {
    Response response = await refresh().post('auth/refresh');

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('refresh token went through');
      print("result : ${response.data}");
      // RefreshResponse res = RefreshResponse.fromJson(jsonDecode(response.data));
      // newToken = res.accessToken;
      // LoginResponse responseData = LoginResponse(
      //     refreshToken: res.refreshToken,
      //     accessToken: res.accessToken
      // );
      // userService.storeToken(responseData);
      return true;
    } else if (response.statusCode == 401) {
      print('refreshAuthToken');
      return false;
    } else {
      
      print('refresh token is wrong');
      storageService.deleteItem(key: StorageKey.REFRESH_TOKEN_TABLE_NAME);
      storageService.deleteItem(key: StorageKey.TOKEN_TABLE_NAME);
      userService.logout();

      return false;
    }
  } catch (e) {
    return false;
  }
}