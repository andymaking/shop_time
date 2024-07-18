import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shoptime/data/repository/repository.service.dart';
import 'package:shoptime/data/repository/repository.service.dart';

import '../../locator.dart';
import '../services/local/navigation.service.dart';
import '../services/local/storage.service.dart';
import '../services/local/user.service.dart';


UserService userService = locator<UserService>();
Repository repository = locator<Repository>();
StorageService storageService = locator<StorageService>();
NavigationService navigationService = locator<NavigationService>();

// CALLING THE DOT ENV FILE
String get baseUrl => dotenv.env['BASE_URL']!;
String get productionBaseUrl => dotenv.env['PRODUCTION_BASE_URL']!;
String get apiKey => dotenv.env['API_KEY']!;
String get appID => dotenv.env['APP_ID']!;
String get organizationID => dotenv.env['ORGANIZATION_ID']!;
String get imagesUrl => dotenv.env['IMAGES_URL']!;