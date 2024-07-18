
import '../../../../data/model/get-product-response.dart';
import '../../../base-vm.dart';

class ProductDetailVoewModel extends BaseViewModel{
  List<Items> items = [];
  Items product = Items();

  init(Items products)async{
    product = products;
    await getBookMarks();
    repository.addRecentlyViewed(products);
    notifyListeners();
  }

  getBookMarks()async{
    var res = await repository.getBookmarks();
    if(res!=null){
      items = res;
    }
    notifyListeners();
  }

  removeBookMark()async {
    var res = await repository.removeLike(product);
    items = res;
    notifyListeners();
  }

  addBookMark()async {
    var res = await repository.addLike(product);
    items = res;
    notifyListeners();
  }

  addToCart(Items itemz) async {
    await repository.addToCart(itemz);
    notifyListeners();
  }

  int currentIndex = 0;

  onChanged(int? index){
    currentIndex = index??0;
    notifyListeners();
  }

}