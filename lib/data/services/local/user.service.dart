import 'dart:convert';

import '../../../locator.dart';
import '../../cache/constants.dart';
import '../../cache/database-keys.dart';
import '../../repository/repository.service.dart';

Repository _repository = locator<Repository>();

class UserService {
  User user = User();
  bool isUserLoggedIn = false;
  bool isUserServiceProvider = false;

  storeToken({required String accessToken, String? refreshToken}) async {
    await storageService.storeItem(key: StorageKey.TOKEN_TABLE_NAME, value: accessToken);
    if(refreshToken!=null){
      await storageService.storeItem(key: StorageKey.REFRESH_TOKEN_TABLE_NAME, value: refreshToken);
    }

    isUserLoggedIn = true;
  }

  initializer() async {
    
    String? userToken = await storageService.read(key: StorageKey.TOKEN_TABLE_NAME);
    if(userToken==null){
      user = User();
      isUserLoggedIn = false;
    }else{
      isUserLoggedIn = true;
      await getStoreUser();
    }
    print("ACCESS TOKEN (AUTH)::: $userToken");
    print("Is User Logged In:::: $isUserLoggedIn");
  }

  // storeUser(User? response) async {
  //   print("Store User");
  //   await storageService.storeItem(key: StorageKey.USER_TABLE_NAME, value: jsonEncode(response));
  //   user = response??User();
  // }

  logout() async {
    
    storageService.deleteAllItems();
    await storageService.deleteAllItems();
    isUserLoggedIn = false;
    user = User();
    // locator<NavigationService>().navigateToAndRemoveUntilWidget(const LoginScreen());
  }


  Future<User?> getStoreUser()  async {
    String? data = await storageService.readItem(key: StorageKey.USER_TABLE_NAME);
    if(data==null){
      // var response = await _repository.getUser();
      // if(response.isRight()){
      //   user = response.asRight();
      //   return user;
      // }else{
      //   user = User();
      //   await logout();
      //   return null;
      // }
      return null;
    }else{
      User userResponse = User.fromJson(jsonDecode(data));
      user = userResponse;
      // _repository.getUser();
      return user;
    }
  }

}

class User {
  String? message;

  User({this.message});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}