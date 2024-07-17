import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/cache/constants.dart';

class BottomSheetAppBar extends StatelessWidget {
  const BottomSheetAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 30.0.sbW,
        Container(
          height: 8.sp,
          width: 80.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.3)
          ),
        ),
      ],
    );
  }
}