import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/cache/palette.dart';
import '../utils/widget_extensions.dart';

class AuthProgressIndicator extends StatelessWidget {
  final int total;
  final int current;
  const AuthProgressIndicator({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
            (i) => Container(
          height: 4.sp,
          width: (width(context) - (88 + (total*4)))/total,
          margin: 2.0.padH,
          color: (current -1) == i|| (current -1) > i ? primaryColor : const Color(0xFFE5DEDE),
        ),
      ),
    );
  }
}