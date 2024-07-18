import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-card.dart';

import '../../../widget/app-bar-widget.dart';
import '../../base-ui.dart';
import 'profile-home.vm.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      onModelReady: (m)=> m.initOrder(),
      builder: (_, model, theme, child)=> Scaffold(
        appBar: const AppBars(
          text: "Orders",
        ),
        body: Padding(
          padding: 16.sp.padH,
          child: ListView.builder(
            itemCount: model.orders.length,
            itemBuilder: (_, i){
              return AppCard(
                bordered: true,
                margin: 16.sp.padB,
              );
            },
          ),
        ),
      ),
    );
  }
}
