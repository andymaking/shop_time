import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shoptime/utils/dartz.x.dart';

import '../../locator.dart';
import '../../utils/snack_message.dart';
import '../cache/constants.dart';
import '../cache/database-keys.dart';
import '../model/default.model.dart';
import '../model/get-product-response.dart';
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


  Future<void> addToCart(Items item) async {
    try {
      var res = await getCart();

      if (res != null) {
        List<Items> items = res;

        // Check if the item already exists in the cart
        bool itemExists = items.any((element) => element.id == item.id);

        if (itemExists) {
          showCustomToast("${item.name} is already in the cart");
        } else {
          item.updateQuantity(1);
          items.add(item);
          await storageService.storeItem(key: StorageKey.PRODUCTS, value: getItemsDataListToJson(items));
          showCustomToast("${item.name} added to cart successfully");
        }
      } else {
        // If the cart is empty, add the first item
        item.updateQuantity(1);
        List<Items> items = [item];
        await storageService.storeItem(key: StorageKey.PRODUCTS, value: getItemsDataListToJson(items));
        showCustomToast("${item.name} added to cart successfully");
      }
    } catch (e) {
      print("Error adding item to cart: $e");
      showCustomToast("An error occurred while adding item to cart");
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


}