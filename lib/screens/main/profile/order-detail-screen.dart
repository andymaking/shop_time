import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/utils/widget_extensions.dart';

import '../../../data/cache/constants.dart';
import '../../../data/cache/network_config.dart';
import '../../../data/model/get-product-response.dart';
import '../../../utils/utils.dart';
import '../../../widget/app-card.dart';
import '../../../widget/apptexts.dart';
import '../cart/cart.ui.dart';
import '../home/product-details/product-detail.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    List<Items> products = getGetItemsDataListFromJson(jsonEncode(order["products_sold"]));

    goToDetails(Items product){
      navigationService.navigateToWidget(ProductDetailPage(product: product,));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Detail"),
      ),
      body: Padding(
        padding: 16.sp.padH,
        child: ListView(
          children: [
            Hero(
              tag: order["id"],
              child: AppCard(
                backgroundColor: Theme.of(context).primaryColor,
                bordered: true,
                margin: 16.sp.padB,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PriceOption(
                      title: "Total Price",
                      value: order["pay_price"]??0,
                      paddingBottom: 3,
                    ),
                    PriceOption(
                      title: "Delivery Fee",
                      value: order["delivery_fee"]??0,
                      paddingBottom: 3,
                    ),
                    PriceOthersOption(
                      title: "Email",
                      value: order["email"],
                      paddingBottom: 3,
                    ),
                    PriceOthersOption(
                      title: "Phone Number",
                      value: order["phone"],
                      paddingBottom: 3,
                    ),
                    PriceOthersOption(
                      title: "Number of Products",
                      value: order["products_sold"].length.toString(),
                      paddingBottom: 3,
                    ),
                    PriceOthersOption(
                      title: "Date",
                      value: Utils.toDates(DateTime.parse(order["date"])),
                      paddingBottom: 0,
                    ),
                    PriceOthersOption(
                      title: "Address",
                      value: order["address"],
                      paddingBottom: 0,
                    ),

                    // const AppText("Tap to view products", align: TextAlign.center,),
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (_,index){
                  return AppCard(
                    onTap: ()=> goToDetails(products[index]),
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
        ),
      ),
    );
  }
}
