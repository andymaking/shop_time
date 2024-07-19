import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/model/get-product-response.dart';
import 'package:shoptime/utils/utils.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-card.dart';

import '../../../data/cache/network_config.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/apptexts.dart';
import '../../base-ui.dart';
import '../cart/cart.ui.dart';
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
              List<Items> products = getGetItemsDataListFromJson(jsonEncode(model.orders[i]["products_sold"]));

              return Column(
                children: [
                  AppCard(
                    backgroundColor: Theme.of(context).primaryColor,
                    bordered: true,
                    margin: 16.sp.padB,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PriceOption(
                          title: "Total Price",
                          value: model.orders[i]["pay_price"]??0,
                        ),
                        PriceOption(
                          title: "Delivery Fee",
                          value: model.orders[i]["delivery_fee"]??0,
                        ),
                        PriceOthersOption(
                          title: "Number of Products",
                          value: model.orders[i]["products_sold"].length.toString(),
                        ),
                        PriceOthersOption(
                          title: "Date",
                          value: Utils.toDates(DateTime.parse(model.orders[i]["date"])),
                        ),
                        // const AppText("Tap to view products", align: TextAlign.center,),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (_,index){
                        return AppCard(
                          onTap: ()=> model.goToDetails(products[index]),
                          bordered: true,
                          padding: 0.0.padA,
                          margin: 10.sp.padB,
                          child: Row(
                            children: [
                              Hero(
                                tag: products[index].photos?.first.url??"",
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: 20.sp.padA,
                                  height: width(context)*0.3,
                                  width: width(context)*0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      color: Theme.of(context).colorScheme.secondary
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: NetworkConfig.IMAGES_URL+(products[index].photos?.first.url??""),
                                  ),
                                ),
                              ),
                              10.sp.sbW,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Hero(
                                      tag: "title/${products[index].name??""}",
                                      child: AppText(
                                        products[index].name??"",
                                        size: 11.sp,
                                        weight: FontWeight.w600,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    10.sp.sbH,
                                    Hero(
                                      tag: "title/${products[index].description??""}",
                                      child: AppText(
                                        products[index].description??"",
                                        size: 11.sp,
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    10.sp.sbH,
                                    RatingBar.builder(
                                      initialRating: 4.5,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemSize: 15.sp,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        CupertinoIcons.star_fill,
                                        color: const Color(0xFFFFA000),
                                        size: 15.sp,
                                      ),
                                      onRatingUpdate: (rating) {
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              10.sp.sbW
                            ],
                          ),
                        );
                      }
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
