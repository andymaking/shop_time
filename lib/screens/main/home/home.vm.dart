import 'package:flutter/cupertino.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/utils/dartz.x.dart';

import '../../../data/model/get-product-response.dart';
import '../../base-vm.dart';
import 'product-details/product-detail.dart';

class HomeViewModel extends BaseViewModel {

  List<Items> allProducts = [];
  List<Items> techProducts = [];
  List<Items> menProducts = [];
  List<Items> womenProducts = [];

  goToDetails(Items product){
    navigationService.navigateToWidget(ProductDetailPage(product: product,));
  }

  init()async{
    getLocalProducts();
    getProducts();
  }

  List<List<Items>> chunkList(List<Items> list, int chunkSize) {
    List<List<Items>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  List<List<Items>> chunkGagdetList = [];
  List<List<Items>> chunkMenList = [];
  List<List<Items>> chunkWomenList = [];

  var gagdetPageController = PageController();
  var womenPageController = PageController();
  var menPageController = PageController();

  int gagdetIndex = 0;
  int womenIndex = 0;
  int menIndex = 0;

  getProducts()async{
    startLoader();
    try{
      var res = await repository.getProducts();
      if(res.isRight()){
        allProducts = res.asRight().items??[];
        print("All LIST LENGTH ${allProducts.length}");
        await sortList(allProducts);
      }
      stopLoader();
      notifyListeners();
    }catch(err){
      debugPrint(err.toString());
      stopLoader();
    }
  }

  getLocalProducts()async{
    try{
      var res = await repository.getLocalProducts();
      if(res?.items!=null){
        allProducts = res?.items??[];
        print("All LIST LENGTH ${allProducts.length}");
        await sortList(allProducts);
      }
      notifyListeners();
    }catch(err){
      debugPrint(err.toString());
    }
  }

  addToCart(Items item) async {
    await repository.addToCart(item);
    notifyListeners();
  }
  
  sortList(List<Items> allProducts)async{
    techProducts = allProducts.where((element) =>
    element.categories != null &&
        element.categories!.any((category) =>
        category.name != null &&
            category.name!.contains("tech")
        )
    ).toList();
    menProducts = allProducts.where((element) =>
    element.categories != null &&
        element.categories!.any((category) =>
        category.name != null &&
            category.name== "men’s fashion"
        )
    ).toList();
    womenProducts = allProducts.where((element) =>
    element.categories != null &&
        element.categories!.any((category) =>
        category.name != null &&
            category.name!.contains("women")
        )
    ).toList();

    chunkGagdetList = chunkList(techProducts, 2);
    chunkMenList = chunkList(menProducts, 2);
    chunkWomenList = chunkList(womenProducts, 2);
    notifyListeners();
  }

  changeGagdetView(int? index){
    gagdetIndex = index??0;
    notifyListeners();
  }

  changeWomenView(int? index){
    womenIndex = index??0;
    notifyListeners();
  }

  changeMenView(int? index){
    menIndex = index??0;
    notifyListeners();
  }

  jump(int index){
    gagdetPageController.jumpToPage(index);
    notifyListeners();
  }

  jumpWomen(int index){
    womenPageController.jumpToPage(index);
    notifyListeners();
  }

  jumpMen(int index){
    menPageController.jumpToPage(index);
    notifyListeners();
  }



}