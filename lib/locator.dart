import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/repository/repository.service.dart';
import '../data/services/local/cache.service.dart';
import '../data/services/local/locale.service.dart';
import '../data/services/local/navigation.service.dart';
import '../data/services/local/storage.service.dart';
import '../data/services/local/theme.service.dart';
import '../data/services/local/user.service.dart';
import 'data/services/web/shop.service.dart';
import 'screens/base-vm.dart';
import 'screens/main/bottom.nav.vm.dart';
import 'screens/main/cart/cart.vm.dart';
import 'screens/main/home/home.vm.dart';
import 'screens/main/home/product-details/product-detail.vm.dart';
import 'screens/main/profile/profile-home.vm.dart';


GetIt locator = GetIt.I;

setupLocator() {
  registerViewModel();
  setUpServices();
}

setUpServices(){
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<Repository>(() => Repository());
  locator.registerLazySingleton<AppCache>(() => AppCache());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<ThemeModel>(() => ThemeModel());
  locator.registerLazySingleton<LocaleService>(() => LocaleService());
  locator.registerLazySingleton<ShopService>(() => ShopService());
}

registerViewModel(){
  /* TODO Setup viewModels*/
  locator.registerFactory<BaseViewModel>(() => BaseViewModel());
  locator.registerFactory<BottomNavigationViewModel>(() => BottomNavigationViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<CartViewModel>(() => CartViewModel());
  locator.registerFactory<ProductDetailVoewModel>(() => ProductDetailVoewModel());
  locator.registerFactory<ProfileHomeViewModel>(() => ProfileHomeViewModel());
}