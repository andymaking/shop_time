import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/data/cache/network_config.dart';
import 'package:shoptime/data/model/get-product-response.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/inidicator.dart';

import '../../../../widget/app-bar-widget.dart';
import '../../../../widget/app-button.dart';
import '../../../../widget/app-card.dart';
import '../../../../widget/apptexts.dart';
import '../../../base-ui.dart';
import '../../cart/cart.ui.dart';
import 'product-detail.vm.dart';

class ProductDetailPage extends StatelessWidget {
  final Items product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailVoewModel>(
      onModelReady: (m)=> m.init(product),
      builder: (_, model, theme, child)=> Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  height: height(context)/3,
                  width: width(context),
                  color: Theme.of(context).colorScheme.secondary,
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: model.onChanged,
                        scrollDirection: Axis.horizontal,
                        itemCount: product.photos?.length,
                        itemBuilder: (_, i){
                          return Hero(
                            tag: product.photos?[i].url??"",
                            child: Container(
                              margin: 40.sp.padA,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(NetworkConfig.IMAGES_URL+(product.photos?[i].url??""))
                                  )
                              ),
                            ),
                          );
                        }
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: 10.sp.padA,
                          child: Indicators(initial: product.photos?.length??0, current: model.currentIndex, isVertical: false),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
                      children: [
                        Hero(
                          tag: "title/${product.name??""}",
                          child: AppText(
                            product.name??"", size: 24.sp,
                            isBold: true,
                          ),
                        ),
                        16.sp.sbH,
                        Hero(
                          tag: "title/${product.description??""}",
                          child: AppText(
                            product.description??"",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.sp),
                          ),
                        ),
                        16.sp.sbH,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                                "Catergories"
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40.sp,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.categories?.length,
                                    itemBuilder: (_, i){
                                      return Column(
                                        children: [
                                          AppCard(
                                            margin: 10.sp.padH,
                                            color: Colors.black,
                                            padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 9.sp),
                                            expandable: true,
                                            child: AppText(
                                              product.categories?[i].name??"",
                                              color: Colors.white,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.sp.sbH,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AppText(
                                "Price"
                            ),
                            AppText(
                              "  NGN ${product.currentPrice?[0].value}",
                              weight: FontWeight.w700,
                              size: 15.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        16.sp.sbH,
                        Row(
                          children: [
                            AppButton(
                              isLoading: false,
                              transparent: true,
                              text: "Add to cart",
                              onTap:()=> model.addToCart(product),
                            ),
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
            SizedBox(
              height: 130.sp,
              child: AppBars(
                actions: [
                  NewIconButtons(
                    icon: Icon(
                      model.items.any((element) => element.id == product.id)?
                      CupertinoIcons.heart_fill: CupertinoIcons.heart,
                      color: model.items.any((element) => element.id == product.id)? Colors.red: null,
                    ),
                    onTap: model.items.any((element) => element.id == product.id)? model.removeBookMark: model.addBookMark,
                  ),
                  NewIconButtons(
                    iconImage: AppImages.cart,
                    onTap: ()=> navigationService.navigateToWidget(const CartHomeScreen()),
                  ),
                  5.sp.sbW
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewIconButtons extends StatelessWidget {
  final String? iconImage;
  final Widget? icon;
  final VoidCallback onTap;
  const NewIconButtons({super.key, this.iconImage, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 35.sp,
          width: 35.sp,
          margin: 5.sp.padH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.sp),
            border: Border.all(width: 0.8.sp, color: Theme.of(context).iconTheme.color!.withOpacity(0.5))
          ),
          alignment: Alignment.center,
          child: icon?? SvgPicture.asset(iconImage??"", height: 26.sp, width: 26.sp, color: Colors.black,),
        ),
      ),
    );
  }
}