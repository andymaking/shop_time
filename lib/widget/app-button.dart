import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/cache/palette.dart';
import 'apptexts.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? transparent;
  final bool? gradient;
  final bool? borderless;
  final bool? noHeight;
  final double? borderWidth;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? textSize;
  final Color? borderColor;
  final Color? backGroundColor;
  final Color? textColor;
  final String? text;
  final List<Color>? gradientColors;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? buttonSpacing;
  final bool isLoading;
  final bool isExpanded;
  final bool? useFull;
  const AppButton({
    super.key,
    this.onTap,
    this.transparent,
    this.gradient,
    required this.isLoading,
    this.gradientColors,
    this.child,
    this.width,
    this.borderWidth,
    this.borderColor,
    this.textColor,
    this.backGroundColor,
    this.text,
    this.borderRadius,
    this.padding,
    this.height,
    this.textSize,
    this.isExpanded = true,
    this.borderless, this.buttonSpacing, this.noHeight, this.useFull
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading == true ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius??12.sp),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 52.sp,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius??12.sp),
            color: buttonShadowColor,
          ),
          child: Container(
            height: noHeight!= null? null: (height ?? 48.sp),
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius??12.sp),
              border: Border.all(width: borderWidth ?? 1.sp, color: borderColor ?? appBorderColor),
              color: backGroundColor != null?
              (onTap == null || isLoading==true? backGroundColor?.withOpacity(0.5): backGroundColor?.withOpacity(0.95))  :
              (onTap == null || isLoading==true ? disablePrimaryColor : primaryColor.withOpacity(0.95)),
            ),
            child: Padding(
                padding:
                padding?? EdgeInsets.symmetric(horizontal: 5.0.sp, vertical: 5.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading? SpinKitThreeBounce(
                      size: 30,
                      itemBuilder: (context, index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: index.isEven
                                ? const Color(0xFF814309)
                                : const Color(0xFFDCDFFF),
                          ),
                        );
                      },
                    ): child ??
                        AppText(
                          text ?? "",
                          // family: 'Inter',
                          weight: FontWeight.w700,
                          color: textColor!=null?(onTap==null? textColor?.withOpacity(0.3): textColor): Colors.white,
                          align: TextAlign.center,
                          size: textSize?? 16.sp,
                        ),

                  ],
                )),
          ),
        ),
      ),
    );
  }

}