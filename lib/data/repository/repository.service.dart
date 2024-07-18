import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:shoptime/utils/dartz.x.dart';

import '../../locator.dart';
import '../../utils/snack_message.dart';
import '../cache/constants.dart';
import '../cache/database-keys.dart';
import '../model/default.model.dart';
import '../model/get-product-response.dart';
import '../model/product-data.dart';
import '../services/web/shop.service.dart';

ShopService _shopService = locator<ShopService>();

class Repository {

  Future<Either<ResModel, GetProductResponse>> getProducts() async {
    var response = await _shopService.getProducts();
    if(response.isRight()){
      storeProducts(response.asRight());
    }
    return response;
  }

  String generateRandomChatId() {
    const allowedChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const allowedSymbols = '!@#\$%^&*()-_=+[]{};:<>,.?/';

    final firstPart = String.fromCharCodes(List.generate(5, (_) => allowedChars.codeUnitAt(Random().nextInt(allowedChars.length))));
    final middlePart = String.fromCharCodes(List.generate(23, (_) => Random().nextBool() ? allowedChars.codeUnitAt(Random().nextInt(allowedChars.length)) : allowedSymbols.codeUnitAt(Random().nextInt(allowedSymbols.length))));
    final lastPart = String.fromCharCodes(List.generate(2, (_) => allowedChars.codeUnitAt(Random().nextInt(allowedChars.length))));

    return firstPart + middlePart + lastPart;
  }

  Future<bool> createSale({
    required List<Items> products,
    required String email,
    required String phoneNumber,
    required String address,
    required num totalPrice,
    required num discountedPrice,
    required num deliveryFee,
  }) async {
    List<Map<String, dynamic>> list = await getLocalOrders();
    try{
      var data = {
        "id": generateRandomChatId(),
        "email" : email,
        "phone" : phoneNumber,
        "country_code": "NGN",
        "sales_status": "pending",
        "address": address,
        "payment_method": "CARD",
        "total_price": totalPrice,
        "date": DateTime.now().toString(),
        "discounted_price": discountedPrice,
        "delivery_fee": deliveryFee,
        "products_sold" : getItemsListToJson(products),
      };
      list.add(data);
      print(data);
      print(list);
      await storageService.storeItem(
        key: "ORDERS", value: list
      );
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getLocalOrders()async{
    try{
      var res = await storageService.readItem(key: "ORDERS");
      if(res != null){
        return res;
      }else{
        return [];
      }
    }catch(err){
      print(err);
      return [];
    }
  }

  storeProducts(GetProductResponse response) async{
    await storageService.storeItem(
      key: StorageKey.ALL_PRODUCTS,
      value: jsonDecode(jsonEncode(response))
    );
  }

  Future<GetProductResponse?> getLocalProducts()async{
    var res = await storageService.readItem(key: StorageKey.ALL_PRODUCTS);
    if(res != null){
      return GetProductResponse.fromJson(res);
    }else{
      return null;
    }
  }


  Future<bool> addToCart(Items item) async {
    try {
      var res = await getCart();

      if (res != null) {
        List<Items> items = res;

        // Check if the item already exists in the cart
        bool itemExists = items.any((element) => element.id == item.id);

        if (itemExists) {
          showCustomToast("${item.name} is already in the cart");
          return false;
        } else {
          item.updateQuantity(1);
          items.add(item);
          await storageService.storeItem(key: StorageKey.PRODUCTS, value: getItemsDataListToJson(items));
          showCustomToast("${item.name} added to cart successfully");
          return true;
        }
      } else {
        // If the cart is empty, add the first item
        item.updateQuantity(1);
        List<Items> items = [item];
        await storageService.storeItem(key: StorageKey.PRODUCTS, value: getItemsDataListToJson(items));
        showCustomToast("${item.name} added to cart successfully", success: true);
        return true;
      }
    } catch (e) {
      print("Error adding item to cart: $e");
      showCustomToast("An error occurred while adding item to cart");
      return false;
    }
  }

  Future<List<Items>> addLike(Items item) async {
    try {
      var res = await getBookmarks();
      List<Items> items = res??[];

      if(items.any((element) => element.id == item.id)){
        showCustomToast("Items already liked");
        return items;
      }else{
        items.add(item);
        await storageService.storeItem(key: StorageKey.LIKED_PRODUCTS, value: getItemsDataListToJson(items));
        return items;
      }
    } catch (e) {
      print("Error adding item to cart: $e");
      return [];
    }
  }


  Future<List<Items>> removeLike(Items item) async {

    try {
      var res = await getBookmarks();
      List<Items> items = res??[];

      if(items.any((element) => element.id == item.id)){
        items.removeWhere((element) => element.id == item.id);
        await storageService.storeItem(key: StorageKey.LIKED_PRODUCTS, value: getItemsDataListToJson(items));
        return items;
      }else{
        showCustomToast("${item.name} not saved");
        return items;
      }
    } catch (e) {
      print("Error adding item to cart: $e");
      return [];
    }
  }

  addRecentlyViewed(Items item) async {
    try {
      var res = await getRecentlyViewed();

      if (res != null) {
        List<Items> items = res;

        // Check if the item already exists in the cart
        bool itemExists = items.any((element) => element.id == item.id);

        if (itemExists) {
          items.removeWhere((element) => element.id == item.id);
          items.add(item);
        } else {
          items.add(item);
        }
        print(items.length);
        await storageService.storeItem(key: StorageKey.RECENTLY_VIEWED_PRODUCTS, value: getItemsDataListToJson(items));
      } else {
        List<Items> items = [item];
        print(items.length);
        await storageService.storeItem(key: StorageKey.RECENTLY_VIEWED_PRODUCTS, value: getItemsDataListToJson(items));
      }
    } catch (e) {
      print("Error adding item to cart: $e");
      return [];
    }
  }

  Future <bool> deleteFromCart(int index)async{
    List<Items> res = await getCart()??[];

    if (res.isNotEmpty) {
      res.removeAt(index);
      storeCart(res);
      return true;
    }

    return false;
  }

  storeCart(List<Items> items)async{
    await storageService.storeItem(key: StorageKey.PRODUCTS, value: getItemsDataListToJson(items));
  }

  Future<List<Items>?> getCart()async{
    var res = await storageService.read(key: StorageKey.PRODUCTS);
    if(res != null){
      var response = getGetItemsDataListFromJson(res);
      return response;
    }else{
      return null;
    }
  }

  Future<List<Items>?> getBookmarks()async{
    var res = await storageService.read(key: StorageKey.LIKED_PRODUCTS);
    if(res != null){
      var response = getGetItemsDataListFromJson(res);
      return response;
    }else{
      return null;
    }
  }

  Future<List<Items>?> getRecentlyViewed()async{
    var res = await storageService.read(key: StorageKey.RECENTLY_VIEWED_PRODUCTS);
    if(res != null){
      var response = getGetItemsDataListFromJson(res);
      return response;
    }else{
      return null;
    }
  }


}