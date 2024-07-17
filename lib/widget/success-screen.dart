import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/cache/app-images.dart';
import '../data/cache/palette.dart';
import '../localization/locales.dart';
import '/utils/widget_extensions.dart';
import '/utils/string-extensions.dart';
import 'app-bar-widget.dart';
import 'app-button.dart';
import 'apptexts.dart';

class SuccessScreen extends StatefulWidget {
  final VoidCallback onTap;
  final String? title;
  final String? body;
  final String? image;
  final String? buttonText;
  final Widget? icon;
  const SuccessScreen({
    super.key,
    required this.onTap,
    this.title,
    this.body,
    this.image,
    this.icon,
    this.buttonText
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>  with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  ConfettiController confettiController = ConfettiController();

  void startConfetti() {
    confettiController.play();
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack, // Choose an appropriate curve for bouncing
      ),
    );

    controller.repeat(reverse: true);

    startConfetti();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(),
      body: Stack(
        children: [
          SizedBox(
            height: height(context),
            width: width(context),
            child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 50,
                colors: [Colors.blue, primaryColor, Colors.purple, Colors.yellow, Colors.orange, Colors.green, Colors.brown],
                shouldLoop: true, // Set to true for repeating animation
              ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 25.sp),
            child: Stack(
              children: [
                SizedBox(
                  width: width(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.successPng,
                        width: 92.sp,
                        height: 92.sp,
                      ),
                      16.sp.sbH,
                      AppText(
                        widget.title??"",
                        size: 18.sp,
                        weight: FontWeight.w600,
                        align: TextAlign.center,
                      ),
                      20.sp.sbH,
                      AppText(
                        widget.body??"",
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: 80.sp.padV,
                  child: SizedBox(
                    width: width(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          widget.title??"",
                          size: 22.sp,
                          weight: FontWeight.w600,
                          align: TextAlign.center,
                        ),
                        Padding(
                          padding: 30.sp.padH,
                          child: AppButton(
                            isLoading: false,
                            text: "Done",
                            onTap: widget.onTap,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
