import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../model/default.model.dart';
import 'base.api.service.dart';

class AuthenticationService {

  Future<Either<ResModel, ResModel>> signUp({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String password,
  }) async {
    try {
      Response response = await connect().post("auth/signup/password", data: {
        "phoneNumber": phoneNumber,
        "email": email,
        "name": "$firstName $lastName",
        "gender": gender.toUpperCase(),
        "password": password,
      });
      return Right(ResModel.fromJson(jsonDecode(response.data)));
    } on DioError catch (e) {
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      return Left(ResModel(message: e.toString()));
    }
  }

  Future<Either<ResModel, LoginResponse>> login({
    required String email,
    required String pin
  }) async {
    try {
      Response response = await connect().post("auth/login/password", data: {
        "email": email,
        "password": pin,
      });
      return Right(LoginResponse.fromJson(jsonDecode(response.data)));
    } on DioError catch (e) {
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      return Left(ResModel(message: e.toString()));
    }
  }



}

class LoginResponse {
  String? message;

  LoginResponse({this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}