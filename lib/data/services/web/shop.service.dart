import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../model/default.model.dart';
import '../../model/get-product-response.dart';
import 'base.api.service.dart';

class ShopService {


  Future<Either<ResModel, GetProductResponse>> getProducts() async {
    try {
      Response response = await connect().get("products");

      Map<String, dynamic> jsonResponse = jsonDecode(response.data);
      jsonResponse['items'] = (jsonResponse['items'] as List).map((item) {
        item['current_price'] = transformCurrentPrice(item['current_price']);
        return item;
      }).toList();
      return Right(GetProductResponse.fromJson(jsonResponse));
    } on DioError catch (e) {
      print(e.response.toString());
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      print(e.toString());
      return Left(ResModel(message: e.toString()));
    }
  }

  Future<Either<ResModel, Items>> getProduct({
    required String productID
  }) async {
    try {
      Response response = await connect().get("products/$productID");
      return Right(Items.fromJson(jsonDecode(response.data)));
    } on DioError catch (e) {
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      return Left(ResModel(message: e.toString()));
    }
  }



}

List<Map<String, dynamic>> transformCurrentPrice(List<dynamic> currentPriceList) {
  List<Map<String, dynamic>> newCurrentPriceList = [];

  for (var price in currentPriceList) {
    price.forEach((key, value) {
      if (value != null && value is List && value.isNotEmpty) {
        newCurrentPriceList.add({
          'type': key,
          'value': value.where((element) => element != null).toList()[0],
        });
      }
    });
  }

  return newCurrentPriceList;
}