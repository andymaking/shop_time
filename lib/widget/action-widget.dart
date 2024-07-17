import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/cache/constants.dart';
import '../data/cache/palette.dart';
import '../utils/widget_extensions.dart';
import 'app-button.dart';
import 'apptexts.dart';

class ActionBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? body;
  final String? subTitle;
  final String? cancelButtonText;
  final String? doItButtonText;
  final VoidCallback? otherOnTap;
  final Widget? prefixIcon1;
  final Widget? child;
  final Widget? prefixIcon2;
  final VoidCallback? onTap;
  const ActionBottomSheet({Key? key, required this.title, required this.onTap, this.subTitle, this.cancelButtonText, this.doItButtonText, this.prefixIcon1, this.prefixIcon2, this.otherOnTap, this.body, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.sp)
                  ),
                  margin: 16.0.padA,
                  padding: 16.0.padA,
                  child: child?? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.sp.sbH,
                      AppText(title??"", size: 20.sp, weight: FontWeight.w600, align: TextAlign.center,),
                      10.sp.sbH,
                      AppText(subTitle??"Are you sure you want to ${(title??"").toLowerCase()}?", color: const Color(0xFF6B6B6B), size: 14.sp, align: TextAlign.center,),
                      40.sp.sbH,
                      body??Row(
                        children: [
                          Expanded(
                              child: AppButton(
                                isLoading: false,
                                borderless: true,
                                borderColor: Colors.red,
                                backGroundColor: Colors.white,
                                useFull: true,
                                text: cancelButtonText?? "No",
                                textColor: primaryColor,
                                onTap: otherOnTap?? navigationService.goBack,
                              )
                          ),
                          29.0.sbW,
                          Expanded(
                              child: AppButton(
                                isLoading: false,
                                text: doItButtonText?? "Yes",
                                useFull: true,
                                onTap: ()async{
                                  navigationService.goBack();
                                  onTap ==null? null: onTap!();
                                },
                                textColor: Colors.white,
                                borderWidth: 2,
                                isExpanded: false,
                                backGroundColor: primaryColor,
                              )
                          ),
                        ],
                      ),
                      10.sp.sbH,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}