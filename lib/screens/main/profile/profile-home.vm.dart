import 'package:flutter/material.dart';
import 'package:shoptime/screens/base-vm.dart';
import 'package:shoptime/utils/snack_message.dart';

import '../../../data/cache/constants.dart';
import '../../../data/model/get-product-response.dart';
import '../home/product-details/product-detail.dart';
import 'order_screen.dart';
import 'recently-viewed.ui.dart';
import 'saved-items.ui.dart';

class ProfileHomeViewModel extends BaseViewModel{

  List<Map<String, dynamic>> orders = [];

  initOrder()async{
    startLoader();
    var res = await repository.getLocalOrders();
    orders = res;
    print(orders.length);
    notifyListeners();
    stopLoader();
  }

  goToOrders(){
    navigationService.navigateToWidget(const OrderScreen());
  }

  goToRecentlyViewed(){
    navigationService.navigateToWidget(const RecentlyViewedScreen());
  }

  goToBookmarks(){
    navigationService.navigateToWidget(const SavedItemsScreen());
  }

  var searchController = TextEditingController();
  var searchSavedController = TextEditingController();
  List<Items> recentlyViewedItems = [];
  List<Items> savedItems = [];
  List<Items> searchedRecentlyViewedItems = [];
  List<Items> searchedSavedItems = [];

  onChangeSearch(String? val)async{
    filterSearch();
    notifyListeners();
  }

  onChangeFilter(String? val)async{
    filterSaved();
    notifyListeners();
  }


  removeBookMark(Items product)async {
    var res = await repository.removeLike(product);
    savedItems = res;
    filterSaved();
    notifyListeners();
  }

  addBookMark(Items product)async {
    var res = await repository.addLike(product);
    savedItems = res;
    filterSaved();
    notifyListeners();
  }

  getRecentViewed()async{
    var res = await repository.getRecentlyViewed();
    recentlyViewedItems = res??[];
    filterSearch();
    notifyListeners();
  }

  getSavedItems()async{
    searchSavedController.clear();
    var res = await repository.getBookmarks();
    savedItems = res??[];
    filterSaved();
    notifyListeners();
  }

  filterSaved()async{
    String value = searchSavedController.text.trim();
    if(value.isEmpty){
      searchedSavedItems = savedItems;
      notifyListeners();
    }else{
      searchedSavedItems = savedItems.where((element) => (element.name??"").toLowerCase().contains(value.toLowerCase())||(element.description??"").toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  filterSearch()async{
    String value = searchController.text.trim();
    if(value.isEmpty){
      searchedRecentlyViewedItems = recentlyViewedItems;
      notifyListeners();
    }else{
      searchedRecentlyViewedItems = recentlyViewedItems.where((element) => (element.name??"").toLowerCase().contains(value.toLowerCase())||(element.description??"").toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  addToCart(Items item) async {
    var res = await repository.addToCart(item);
    notifyListeners();
  }

  goToDetails(Items product){
    navigationService.navigateToWidget(ProductDetailPage(product: product,));
  }

}