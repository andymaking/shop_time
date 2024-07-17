import 'package:flutter/material.dart';

import '../../locator.dart';
import '../services/local/cache.service.dart';
import 'routes.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final cache = locator<AppCache>();
    switch (settings.name) {
      // case AuthSelectorRoute:
      //   return MaterialPageRoute(builder: (_) => const AuthSelectorScreen());
      // case LoginRoute:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case SignUpRoute:
      //   return MaterialPageRoute(builder: (_) => const SignUpScreen());
      // case VerifyOTPRoute:
      //   return MaterialPageRoute(builder: (_) => const VerifyOTPScreen());
      // case CreatePinRoute:
      //   return MaterialPageRoute(builder: (_) => const CreatePinScreen());
      // case UserSelectorRoute:
      //   return MaterialPageRoute(builder: (_) => const TypeUserSelectorView());
      // case GiveGroupName:
      //   return MaterialPageRoute(builder: (_) => const GiveGroupNameScreen());
      // case HomeRoute:
      //   return MaterialPageRoute(builder: (_) => const DashBoardScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
