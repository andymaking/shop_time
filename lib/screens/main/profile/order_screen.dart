import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/data/model/get-product-response.dart';
import 'package:shoptime/utils/utils.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-card.dart';

import '../../../data/cache/network_config.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/apptexts.dart';
import '../../base-ui.dart';
import '../cart/cart.ui.dart';
import 'order-detail-screen.dart';
import 'profile-home.vm.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
          child: model.orders.isEmpty? Center(
            child: AppText("No order yet", size: 16.sp, weight: FontWeight.w600,),
          ):
          ListView.builder(
            itemCount: model.orders.length,
            itemBuilder: (_, i){
              goToOrderDetail(){
                navigationService.navigateToWidget(OrderDetailScreen(order: model.orders[i],));
              }
              return Hero(
                tag: model.orders[i]["id"],
                child: AppCard(
                  onTap: goToOrderDetail,
                  backgroundColor: Theme.of(context).primaryColor,
                  bordered: true,
                  margin: 16.sp.padB,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            PriceOption(
                              title: "Total Price",
                              value: model.orders[i]["pay_price"]??0,
                              paddingBottom: 3,
                            ),
                            PriceOption(
                              title: "Delivery Fee",
                              value: model.orders[i]["delivery_fee"]??0,
                              paddingBottom: 3,
                            ),
                            PriceOthersOption(
                              title: "Number of Products",
                              value: model.orders[i]["products_sold"].length.toString(),
                              paddingBottom: 3,
                            ),
                            PriceOthersOption(
                              title: "Date",
                              value: Utils.toDates(DateTime.parse(model.orders[i]["date"])),
                              paddingBottom: 0,
                            ),
                            // const AppText("Tap to view products", align: TextAlign.center,),
                          ],
                        ),
                      ),
                      16.sp.sbW,
                      Icon(Icons.arrow_forward_ios_rounded, size: 16.sp,)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
