import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/utils/widget_extensions.dart';

import '../data/cache/constants.dart';
import 'apptexts.dart';

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLead;
  final Widget? title;
  final Widget? leading;
  final String? text;
  final bool? hasNotification;
  final bool? noLeading;
  final bool centerTile;
  final Widget? flexibleSpace;
  final double? elevation;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? backgroundColor;
  final Color? buttonBackgroundColor;
  final Color? textAppColor;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  const AppBars({Key? key,
    this.hasLead=true, this.title,
    this.actions, this.flexibleSpace,
    this.bottom, this.text,
    this.hasNotification,
    this.leading, this.elevation,
    this.backgroundColor, this.systemOverlayStyle,
    this.textAppColor, this.buttonBackgroundColor, this.noLeading, this.centerTile = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      leading: Navigator.of(context).canPop() ? BackButton() : Padding(
        padding: 14.sp.padL,
        child: Image.asset(
          AppImages.appSplashLogo,
          width: 99.sp,
          height: 31.sp,
        ),
      ),
      title: title??(text!=null? AppText("$text", style: Theme.of(context).textTheme.bodyLarge):null),
      flexibleSpace: flexibleSpace,
      backgroundColor: backgroundColor,
      leadingWidth: Navigator.of(context).canPop() ? 45.sp: 115.sp,
      bottom: bottom,
      actions: actions,
      systemOverlayStyle: systemOverlayStyle,
      scrolledUnderElevation: 0.0,
      centerTitle: centerTile?? true,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackButtons extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  const BackButtons({Key? key, this.onTap, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?? navigationService.goBack,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: 10.0.padL,
          width: 35.sp,
          height: 35.sp,
          padding: 7.0.padA,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Platform.isIOS? Icons.arrow_back_ios_new_outlined : Icons.arrow_back_sharp, size: 16,),
        ),
      ),
    );
  }
}