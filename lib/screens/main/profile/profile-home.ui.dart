import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/palette.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-card.dart';
import 'package:shoptime/widget/apptexts.dart';

import '../../../data/cache/app-images.dart';
import '../../../widget/app-bar-widget.dart';
import '../../base-ui.dart';
import 'profile-home.vm.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      builder: (_, model, theme, child)=> Scaffold(
        appBar: AppBars(
          text: "Account",
          leading: Image.asset(
            AppImages.appSplashLogo,
            width: 99.sp,
            height: 31.sp,
          ),
        ),
        body: Padding(
          padding: 16.sp.padH,
          child: ListView(
            children: [
              16.sp.sbH,
              AppCard(
                bordered: true,
                radius: 10.sp,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileOption(
                      onTap: model.goToOrders,
                      icon: CupertinoIcons.cart,
                      text: "Order History",
                    ),
                    Divider(),
                    ProfileOption(
                      onTap: model.goToBookmarks,
                      icon: CupertinoIcons.heart_circle,
                      text: "Saved Items",
                    ),
                    Divider(),
                    ProfileOption(
                      onTap: model.goToRecentlyViewed,
                      icon: CupertinoIcons.eye,
                      text: "Recently viewed",
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;
  const ProfileOption({
    super.key, required this.onTap, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width(context),
          padding: 10.sp.padV,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 29.sp,
                width: 29.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: primaryColor.withOpacity(0.1)
                ),
                child: Icon(icon, size: 18.sp, color: primaryColor,),
              ),
              16.sp.sbW,
              AppText(text, weight: FontWeight.w600,)
            ],
          ),
        ),
      ),
    );
  }
}
