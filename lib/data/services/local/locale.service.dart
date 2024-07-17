import 'package:flutter/cupertino.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';

import '../../../localization/locales.dart';
import '../../cache/database-keys.dart';

class LocaleService extends ChangeNotifier {

  init()async {
    box = GetStorage();
    localization = FlutterLocalization.instance;
    await getInitLocale();
    supportedLanguages = localization.supportedLocales.map((e) => e.toString()).toList();
  }

  late FlutterLocalization localization;
  String language ="";
  late GetStorage box;
  List<String> supportedLanguages = [];


  saveLocale(String languages) async {
    print(languages);
    box.write(StorageKey.LANGUAGE_CODE, languages);
    await getLocale();
    notifyListeners();
  }

  getLocale()async{
    language = box.read(StorageKey.LANGUAGE_CODE)??"en";
    localization.translate(language);
    notifyListeners();
  }

  getInitLocale()async{
    language = box.read(StorageKey.LANGUAGE_CODE)??"en";
    print("INIT LOCALE LANGUAGE:::::: $language");
    localization.init(mapLocales: LOCALES, initLanguageCode: language);
    notifyListeners();

  }

}