import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/palette.dart';

class Indicators extends StatelessWidget {
  final int initial;
  final int current;
  final bool isVertical;
  final Function(int)? onChange;
  const Indicators({Key? key, required this.initial, required this.current, required this.isVertical, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ! isVertical? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _indicatorContent(context, isVertical)
    ): Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _indicatorContent(context, isVertical)
    );
  }

  List<Widget> _indicatorContent(BuildContext context, bool isVertical) {
    return List<Widget>.generate(initial, (int index) {
      return GestureDetector(
        onTap: (){
          if(onChange != null){
            onChange!(index);
          }
        },
        child: Container(
          width: !isVertical? ( current == index ? 12.sp: 12.sp) : ( current == index ? 12.sp: 12.sp),
          height: isVertical? ( current == index ? 12.sp: 12.sp) : ( current == index ? 12.sp: 12.sp),
          margin: EdgeInsets.symmetric(horizontal:!isVertical? 6.sp: 0.sp, vertical: isVertical? 6.sp: 0.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5.sp),
            border: Border.all(width: 1.sp, color: current == index? primaryColor : const Color(0xFFBBBBBB)),
            color: current == index
                ? primaryColor
                : Colors.transparent,
          ),
        ),
      );
    });
  }
}