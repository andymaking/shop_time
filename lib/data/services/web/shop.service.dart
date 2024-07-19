import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shoptime/data/cache/network_config.dart';

import '../../../utils/get-device-info.dart';
import '../../model/default.model.dart';
import '../../model/get-product-response.dart';
import '../../model/product-data.dart';
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

  // Future<Either<ResModel, ResModel>> createSale({
  //   String? currency,
  //   required List<Items> productSold,
  //   required String email,
  //   required String phoneNumber,
  // }) async {
  //   try {
  //
  //     Map<String, dynamic> data = {
  //       "organization_id" : NetworkConfig.ORGANIZATION_ID,
  //       "currency_code": currency??"NGN",
  //       "customer_title": "Mr/Mrs",
  //       "first_name": await getDeviceName(),
  //       "last_name": await getDeviceIdentifier(),
  //       "email" : email,
  //       "phone" : int.parse(phoneNumber),
  //       "country_code": "NGN",
  //       "mode_of_payment": "bank transfer",
  //       "sales_status": "pending",
  //       "description" : "Sold items to ${await getDeviceName()}",
  //       "products_sold" : getProductDataListToJson(productSold)
  //     };
  //     Response response = await connect().post("products", data: data);
  //
  //     Map<String, dynamic> jsonResponse = jsonDecode(response.data);
  //     return Right(ResModel(message: "Successfully made sale"));
  //   } on DioError catch (e) {
  //     print(e.response.toString());
  //     return Left(ResModel(message: "Error making sale"));
  //   } catch (e) {
  //     print(e.toString());
  //     return Left(ResModel(message: "Error making sale"));
  //   }
  // }

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