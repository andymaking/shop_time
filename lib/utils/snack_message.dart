import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';

import '../data/cache/app-images.dart';
import '../data/cache/constants.dart';
import '../utils/widget_extensions.dart';
import '../widget/apptexts.dart';


Widget toast(String message, {bool? success, String? title}) {
  BuildContext context = navigationService.navigatorKey.currentState!.context;

  return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: 16.sp.padH,
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 14.sp),
              width: double.infinity,
              decoration: BoxDecoration(
                color: !success! ? Theme.of(context).primaryColor : Colors.black,
                borderRadius: BorderRadius.circular(12.sp)
              ),
              child: Row(
                children: [
                  // SvgPicture.asset(success? AppImages.successIcon: AppImages.errorIcon,
                  //   height: 35.sp,
                  //   width: 35.sp,
                  // ),
                  10.0.sbW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        title != null? AppText(
                          title??"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700
                          ),
                        ):0.0.sbW,
                        title != null? 2.sp.sbH :0.0.sbW,
                        AppText(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}

// styled! ?:

showCustomToast(String message, {bool success = false, num? time, String? title}) {

  // toast message
  showToastWidget(
    toast(message, success: success, title: title),
    duration: const Duration(seconds: 4),
    onDismiss: () {},
  );
}