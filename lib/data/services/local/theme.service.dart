import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../cache/constants.dart';
import '../../cache/database-keys.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    getPreferences();
  }

  changeTheme()async{
    _isDark = _isDark == true? false: true;
    setIsDark(_isDark);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await storageService.readItem(key: StorageKey.IS_DARK_MODE)?? false;
    notifyListeners();
  }

  setIsDark(bool value) {
    _isDark = value;
    // _preferences.setTheme(value);
    storageService.storeItem(key: StorageKey.IS_DARK_MODE, value: value);
    value==true?
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    )):
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    notifyListeners();
  }
}