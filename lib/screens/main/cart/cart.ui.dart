import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/data/cache/network_config.dart';
import 'package:shoptime/data/cache/palette.dart';
import 'package:shoptime/utils/shimmer_loaders.dart';
import 'package:shoptime/utils/snack_message.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-button.dart';
import 'package:shoptime/widget/app-card.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/dash-lines.dart';
import 'package:shoptime/widget/image_builder.dart';
import 'package:shoptime/widget/price-widget.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../data/model/get-product-response.dart';
import '../../../widget/app-bar-widget.dart';
import '../../base-ui.dart';
import 'cart.vm.dart';

class CartHomeScreen extends StatelessWidget {
  const CartHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(
      onModelReady: (m)=> m.getCartItems(),
      builder: (_, model, theme, child)=> Scaffold(
        appBar: const AppBars(
          text: "My Cart",
        ),
        body: model.cartItems.isEmpty && !model.isLoading? Center(
          child: AppText(
            "No Item in Cart",
            size: 24.sp,
            weight: FontWeight.w500,
          ),
        ) : model.cartItems.isEmpty && model.isLoading?
        ListView.builder(
          padding: 16.sp.padA,
          itemCount: 3,
          itemBuilder: (_, i){
            return AppCard(
              bordered: true,
              heights: 120.sp,
              padding: 0.sp.padA,
              margin: 16.sp.padB,
              child: const ShimmerCard(),
            );
          }
        ):
        ListView(
          padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.cartItems.length,
              itemBuilder: (_,i){
                Items item = model.cartItems[i];
                num quantity = model.cartItems[i].quantity??0;

                subtractQuantity(){
                  if(quantity == 1){
                    showCustomToast("You can't go below this, delete item if not needed");
                  }else{
                    quantity-=1;
                    item.updateQuantity(quantity);
                    model.updateItem(item, i);
                  }
                }

                addQuantity(){
                  quantity+=1;
                  item.updateQuantity(quantity);
                  model.updateItem(item, i);
                }

                return AppCard(
                  radius: 5.sp,
                  bordered: true,
                  margin: 16.sp.padB,
                  padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 25.sp),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: NetworkConfig.IMAGES_URL+(model.cartItems[i].photos?[0].url??""),
                        height: 78.sp,
                        width: 60.sp,
                      ),
                      16.sp.sbW,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppText(
                                    model.cartItems[i].name??"",
                                    weight: FontWeight.w600,
                                    size: 12.sp,
                                  ),
                                ),
                                16.sp.sbW,
                                NewIconButton(
                                  onPressed: ()=>  model.delete(i),
                                  icon: AppImages.delete,
                                  swap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: AppText(
                                    model.cartItems[i].description??"",
                                    size: 11.sp,
                                    maxLine: 2,
                                  ),
                                ),
                                Expanded(flex: 2,child: 0.0.sbH,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    NewIconButton(onPressed: subtractQuantity, icon: AppImages.minus),
                                    SizedBox(width: 10.sp,),
                                    Padding(
                                      padding: 2.5.padB,
                                      child: AppText(
                                        quantity.toString(), size: 12.sp, weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 26.sp,),
                                    NewIconButton(onPressed: addQuantity, icon: AppImages.plus),

                                  ],
                                ),
                                PriceWidget(
                                  value: quantity * (item.currentPrice?[0].value??0),
                                  weight: FontWeight.w600,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
            10.sp.sbH,
            AppCard(
              radius: 5.sp,
              color: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Shopping Summary",
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                  25.sp.sbH,
                  AppText(
                    "Discount Code",
                    weight: FontWeight.w500,
                    color: textColor.withOpacity(0.63),
                  ),
                  10.sp.sbH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AppTextField(
                          isDark: false,
                          keyboardType: TextInputType.text,
                          controller: model.discountPriceController,
                        ),
                      ),
                      16.sp.sbW,
                      AppButton(
                        isLoading: false,
                        isExpanded: true,
                        text: "Apply",
                        padding: 20.sp.padH,
                        onTap: model.getPrice,
                      )
                    ],
                  ),
                  30.sp.sbH,
                  PriceOption(
                    title: "Sub-Total",
                    value: model.totalPrice,
                  ),
                  PriceOption(
                    title: "Delivery Fee",
                    value: model.deliveryFee,
                  ),
                  PriceOption(
                    title: "Discount Amount",
                    value: model.discountedPrice,
                  ),
                  const DashLines(dashAmount: 26),
                  16.sp.sbH,
                  PriceOption(
                    title: "Total Amount",
                    value: model.payPrice,
                  ),
                  16.sp.sbH,
                  Padding(
                    padding: 22.sp.padH,
                    child: AppButton(
                      isLoading: false,
                      text: "Checkout",
                      onTap: model.navigateToCheckout,
                    ),
                  )
                ],
              ),
            ),
            300.sp.sbH
          ],
        ),
      ),
    );
  }
}

class PriceOption extends StatelessWidget {
  final String title;
  final num value;
  final double? paddingBottom;
  const PriceOption({
    super.key, required this.title, required this.value, this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (paddingBottom??16).sp.padB,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title,
            color: textColor.withOpacity(0.8),
            size: 12.sp,
            weight: FontWeight.w500,
          ),
          Spacer(),
          PriceWidget(
            value: value,
            weight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}

class PriceOthersOption extends StatelessWidget {
  final String title;
  final String value;
  final double? paddingBottom;
  const PriceOthersOption({
    super.key, required this.title, required this.value, this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (paddingBottom??16).sp.padB,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            color: textColor.withOpacity(0.8),
            size: 12.sp,
            weight: FontWeight.w500,
          ),
          16.sp.sbW,
          Expanded(
            child: AppText(
              value,
              weight: FontWeight.w600,
              align: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}

class NewIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final bool? swap;
  const NewIconButton({super.key, required this.onPressed, required this.icon, this.swap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.only(
            top: swap == true? 0.sp:  16.sp, right:swap == true? 0.sp: 16.sp,
          ),
          child: buildSvgPicture(image: icon, size: 20.sp),
        ),
      ),
    );
  }
}

