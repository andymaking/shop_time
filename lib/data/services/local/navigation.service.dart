import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  Future<dynamic> navigateTo(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToWidget(Widget route) {
    // MaterialPageRoute(builder: (_)=> route)
    return navigatorKey.currentState!.push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    ));
  }

  Future<dynamic> navigateToReplaceWidget(Widget route) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_)=> route));
  }

  Future<dynamic> navigateToReplace(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {dynamic argument}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<dynamic> navigateToAndRemoveUntilWidget(Widget route) {
    return navigatorKey.currentState!
        .pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> route), (route) => false);
  }

  goBack({dynamic value}) {
    return navigatorKey.currentState!.pop(value);
  }
}