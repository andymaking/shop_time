import 'package:flutter/material.dart';

import '../../utils/widget_extensions.dart';
import '../data/cache/palette.dart';

class AppCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? color;
  final Color? borderColor;
  final Color? splashColor;
  final double? radius;
  final double? widths;
  final double? blurRadius;
  final double? borderWidth;
  final double? spreadRadius;
  final BorderRadius? borderRadius;
  final double? heights;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Decoration? decoration;
  final VoidCallback? onTap;
  final bool? expandable;
  final bool? useShadow;
  final bool? bordered;
  const AppCard({
    super.key,
    this.backgroundColor,
    this.radius,
    this.widths,
    this.heights,
    this.padding,
    this.margin,
    this.child,
    this.decoration,
    this.onTap,
    this.expandable,
    this.bordered,
    this.useShadow,
    this.borderColor,
    this.blurRadius,
    this.spreadRadius,
    this.borderWidth,
    this.borderRadius,
    this.color,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius??  BorderRadius.circular(radius ?? 16),
      child: Container(
        decoration: decoration?? BoxDecoration(
          color: color??(backgroundColor!=null ? backgroundColor!.withOpacity(0.9): Colors.transparent),
          borderRadius: borderRadius??  BorderRadius.circular(radius ?? 16),
          boxShadow: useShadow != true
              ? null
              : [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: blurRadius ?? 1,
              blurStyle: BlurStyle.normal,
              spreadRadius: spreadRadius ?? 0.5),
          ],
          border: bordered == true
            ? Border.all(
            color: borderColor ?? primaryColor,
            width: borderWidth ?? 2)
            : null
        ),
        margin: margin ?? 0.0.padH,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius?? BorderRadius.circular(radius ?? 16),
            child: Container(
              height: heights,
              width: widths ?? (expandable == true ? null : width(context)),
              padding: padding ?? 16.0.padA,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}