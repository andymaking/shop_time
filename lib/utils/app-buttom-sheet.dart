import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/cache/constants.dart';
import 'widget_extensions.dart';
import '../widget/drawer-appbar.dart';

Future<dynamic> appBottomSheet({required double ratio, required Widget child, BuildContext? contexts }) async {
  BuildContext context = contexts?? navigationService.navigatorKey.currentState!.context;
  return await showCupertinoModalSheet(
      context: context,
      builder: (_){
        double heights = ratio;
        return DraggableScrollableSheet(
            initialChildSize: heights,
            snap: true,
            maxChildSize: 0.95,
            snapSizes: [heights, (heights+0.95)/2 ,0.95],
            builder:(_, scroll){
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(_).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      controller: scroll,
                      child: Padding(
                        padding: 16.sp.padA,
                        child: const BottomSheetAppBar(),
                      ),
                    ),
                    Expanded(
                      child: child,
                    )
                  ],
                ),
              );
            }
        );
      }
  );
}
