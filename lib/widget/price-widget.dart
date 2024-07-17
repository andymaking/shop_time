import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/string-extensions.dart';
import '/utils/widget_extensions.dart';

import 'apptexts.dart';

class PriceWidget extends StatelessWidget {
  final dynamic value;
  final double? size;
  final num? spaceSize;
  final Color? color;
  final String? family;
  final bool? roundUp;
  final bool isDollar;
  final bool isBold;
  final int? decimalPlaces;
  final double? iconSize;
  final FontWeight? weight;
  const PriceWidget({super.key, this.value, this.size, this.color, this.roundUp, this.family, this.isBold = false, this.weight, this.isDollar = false, this.decimalPlaces, this.iconSize, this.spaceSize});

  @override
  Widget build(BuildContext context) {


    String text = value==null?"0.00": roundUp==true? (double.tryParse(value.toStringAsFixed(2))??0.00).floor().toString(): (double.tryParse(value.toStringAsFixed(2))??0.00).toStringAsFixed(2);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          isDollar? "\$" : "₦",
          size: iconSize?? size,
          weight: weight,
          color: color,
          family: isDollar? null : 'Inter',
        ),
        spaceSize==null? 0.0.sbW: spaceSize!.sp.sbW,
        Text(
          formatNumber(double.tryParse(text)??0, roundUp: roundUp, decimalPlaces: decimalPlaces),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: size,
            fontWeight: isBold? FontWeight.w600: weight,
            color: color,
            fontFamily: family,
          ),
        )
      ],
    );

    //   RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: isDollar == true? "\$" : "₦",
    //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //           fontSize: iconSize?? fontSize,
    //           fontWeight: fontWeight,
    //           fontFamily: "Inter",
    //           color: color,
    //         ),
    //       ),
    //       TextSpan(
    //         text: formatNumber(double.tryParse(text)??0, roundUp: roundUp, decimalPlaces: decimalPlaces),
    //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //           fontSize: fontSize,
    //           fontWeight: isBold? FontWeight.w600: fontWeight,
    //           color: color,
    //           fontFamily: family,
    //         ),
    //       ),
    //     ],
    //   ),
    //   textAlign: TextAlign.center,
    // );
  }
}