import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/cache/constants.dart';
import '../../data/cache/database-keys.dart';
import '../../data/routes/routes.dart';
import '../../localization/locales.dart';
import '../../widget/image_builder.dart';
import '../../data/cache/app-images.dart';
import '../../data/cache/palette.dart';
import '../../utils/string-extensions.dart';
import '../../utils/widget_extensions.dart';
import '../main/bottom.nav.ui.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool? isLogIn = false;
  bool? isUserSetPin = false;
  bool? onBoardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // HANDLE NAVIGATION AFTER SPLASH SCREEN
          appRelaunch();
        }
      });
  }
  Future<Object> appRelaunch() async {
    return navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.scale(
                  scale: _controller.value * 2,
                  child: child,
                );
              },
              child: buildImagePicture(
                image: AppImages.appSplashLogo,
                size: 72.sp
              ),
            ),
            16.sp.sbH,
            Container(
              alignment: Alignment.center,
              padding: 10.sp.padA,
              child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Andima",
                      semanticsLabel: "Andima",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Shop",
                          semanticsLabel: "Shop",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]))),
            )
          ],
        ),
      ),
    );
  }
}
