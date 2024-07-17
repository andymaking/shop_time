import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../locator.dart';
import '../services/local/navigation.service.dart';
import '../services/local/storage.service.dart';
import '../services/local/user.service.dart';


UserService userService = locator<UserService>();
StorageService storageService = locator<StorageService>();
NavigationService navigationService = locator<NavigationService>();

// CALLING THE DOT ENV FILE
String get baseUrl => dotenv.env['BASE_URL']!;
String get productionBaseUrl => dotenv.env['PRODUCTION_BASE_URL']!;
String get publicKey => dotenv.env['FLW_PUBLIC_KEY']!;
String get secretKey => dotenv.env['FLW_SECRET_KEY']!;