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
import '../data/services/web/authentication.service.dart';


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
  // locator.registerLazySingleton<ExchangeService>(() => ExchangeService(locator<Dio>()));
  // locator.registerLazySingleton<LocationViewModel>(() => LocationViewModel());
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
}

registerViewModel(){
  /* TODO Setup viewModels*/
  // locator.registerFactory<BaseViewModel>(() => BaseViewModel());
  // locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  // locator.registerFactory<HomeTabViewModel>(() => HomeTabViewModel());
  // locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  // locator.registerFactory<SettingsViewModel>(() => SettingsViewModel());
  // locator.registerFactory<SendMoneyViewModel>(() => SendMoneyViewModel());
  // locator.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  // locator.registerFactory<ProfileEditViewModel>(() => ProfileEditViewModel());
  // locator.registerFactory<ProfileHomeViewModel>(() => ProfileHomeViewModel());
  // locator.registerFactory<SettingsViewModel>(() => SettingsViewModel());
}