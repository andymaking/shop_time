import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/data/cache/network_config.dart';
import 'package:shoptime/data/model/get-product-response.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-button.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/inidicator.dart';
import 'package:shoptime/widget/price-widget.dart';

import '../../../utils/shimmer_loaders.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/app-card.dart';
import '../../base-ui.dart';
import 'home.vm.dart';
import 'product-details/product-detail.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (m)=> m.init(),
      builder: (_, model, theme, child)=> Scaffold(
        body: Column(
          children: [

            SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: 16.sp.padH,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppImages.appSplashLogo,
                      width: 99.sp,
                      height: 31.sp,
                    ),
                    AppText("Account", size: 20.sp, weight: FontWeight.w600,),
                    NewIconButtons(
                      iconImage: AppImages.cart,
                      onTap: model.goToOrders,
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
                children: [
                  Container(
                    height: 232.sp,
                    width: width(context),
                    alignment: Alignment.centerLeft,
                    padding: 30.sp.padA,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: const DecorationImage(
                        image: AssetImage(
                          AppImages.headset,
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Premium Sound, \nPremium Savings",
                          color: Colors.white,
                          size: 20.sp,
                          weight: FontWeight.w600,
                        ),
                        5.sp.sbH,
                        AppText(
                          "Limited offer, hope on and get yours now",
                          color: Colors.white,
                          size: 12.sp,
                          weight: FontWeight.w500,
                        ),

                      ],
                    ),
                  ),
                  30.sp.sbH,
                  model.isLoading && model.allProducts.isEmpty?
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: (1 / 1.4),
                      ),
                      itemBuilder: (_,i){
                        return AppCard(
                          padding: 0.0.padA,
                          margin: (i % 2) == 1
                              ? const EdgeInsets.only(
                              left: 5,bottom: 5)
                              : const EdgeInsets.only(
                              right: 5, bottom: 5
                          ),
                          child: ShimmerCard(),
                        );
                      }
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Tech Gadget", size: 20.sp, weight: FontWeight.w600),
                      20.sp.sbH,
                      SizedBox(
                        height: 346.92.sp,
                        width: width(context),
                        child: PageView.builder(
                            controller: model.gagdetPageController,
                            itemCount: model.chunkGagdetList.length,
                            onPageChanged: model.changeGagdetView,
                            itemBuilder: (_, i){
                              List<Items> pageItems = model.chunkGagdetList[i];
                              return GridView.builder(
                                padding: 0.0.padA,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pageItems.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.sp,
                                    mainAxisSpacing: 8.sp,
                                    childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                                    // Set the itemExtent to fix the height of each item
                                    // You may need to adjust the value based on your design
                                    mainAxisExtent: 346.92.sp,
                                  ),
                                  itemBuilder: (_,i){
                                    return ProductCard(
                                      pageItems: pageItems,
                                      i: i,
                                      onTap: ()=> model.addToCart(pageItems[i]),
                                      goToDetails: ()=> model.goToDetails(pageItems[i],"Tech Gadget", model.techProducts),
                                    );
                                  }
                              );
                            }
                        ),
                      ),
                      16.sp.sbH,
                      Indicators(
                        initial: model.chunkGagdetList.length,
                        current: model.gagdetIndex,
                        isVertical: false,
                        onChange: model.jump,
                      ),
                      50.sp.sbH,
                      AppText("Men’s Fashion", size: 20.sp, weight: FontWeight.w600),
                      20.sp.sbH,
                      SizedBox(
                        height: 346.92.sp,
                        width: width(context),
                        child: PageView.builder(
                            controller: model.menPageController,
                            itemCount: model.chunkMenList.length,
                            onPageChanged: model.changeMenView,
                            itemBuilder: (_, i){
                              List<Items> pageItems = model.chunkMenList[i];
                              return GridView.builder(
                                  padding: 0.0.padA,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pageItems.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.sp,
                                    mainAxisSpacing: 8.sp,
                                    childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                                    // Set the itemExtent to fix the height of each item
                                    // You may need to adjust the value based on your design
                                    mainAxisExtent: 346.92.sp,
                                  ),
                                  itemBuilder: (_,i){
                                    return ProductCard(
                                      pageItems: pageItems,
                                      i: i,
                                      onTap: ()=> model.addToCart(pageItems[i]),
                                      goToDetails: ()=> model.goToDetails(pageItems[i],"Mens’s Fashion", model.menProducts),
                                    );
                                  }
                              );
                            }
                        ),
                      ),
                      16.sp.sbH,
                      Indicators(
                        initial: model.chunkMenList.length,
                        current: model.menIndex,
                        isVertical: false,
                        onChange: model.jumpMen,
                      ),
                      50.sp.sbH,
                      AppText("Women’s Fashion", size: 20.sp, weight: FontWeight.w600),
                      20.sp.sbH,
                      SizedBox(
                        height: 346.92.sp,
                        width: width(context),
                        child: PageView.builder(
                            controller: model.womenPageController,
                            itemCount: model.chunkWomenList.length,
                            onPageChanged: model.changeWomenView,
                            itemBuilder: (_, i){
                              List<Items> pageItems = model.chunkWomenList[i];
                              return GridView.builder(
                                  padding: 0.0.padA,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pageItems.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.sp,
                                    mainAxisSpacing: 8.sp,
                                    childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                                    // Set the itemExtent to fix the height of each item
                                    // You may need to adjust the value based on your design
                                    mainAxisExtent: 346.92.sp,
                                  ),
                                  itemBuilder: (_,i){
                                    return ProductCard(
                                      pageItems: pageItems,
                                      i: i,
                                      onTap: ()=> model.addToCart(pageItems[i]),
                                      goToDetails: ()=> model.goToDetails(pageItems[i],"Women’s Fashion", model.womenProducts),
                                    );
                                  }
                              );
                            }
                        ),
                      ),
                      16.sp.sbH,
                      Indicators(
                        initial: model.chunkWomenList.length,
                        current: model.womenIndex,
                        isVertical: false,
                        onChange: model.jumpWomen,
                      )
                    ],
                  ),
                  1000.sp.sbH
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.pageItems, required this.i, required this.onTap, required this.goToDetails,
  });

  final List<Items> pageItems;
  final int i;
  final VoidCallback onTap;
  final VoidCallback goToDetails;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: goToDetails,
      radius: 5.sp,
      padding: 0.0.padA,
      margin: (i % 2) == 1
          ? const EdgeInsets.only(
          left: 5,bottom: 5)
          : const EdgeInsets.only(
          right: 5, bottom: 5
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: pageItems[i].photos?.first.url??"",
            child: Container(
              alignment: Alignment.center,
              padding: 30.sp.padA,
              height: 184.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  color: Theme.of(context).colorScheme.secondary
              ),
              child: CachedNetworkImage(
                imageUrl: NetworkConfig.IMAGES_URL+(pageItems[i].photos?.first.url??""),
              ),
            ),
          ),
          10.sp.sbH,
          Hero(
            tag: "title/${pageItems[i].name??""}",
            child: AppText(
              pageItems[i].name??"",
              size: 12.sp,
              weight: FontWeight.w600,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          10.sp.sbH,
          Hero(
            tag: "title/${pageItems[i].description??""}",
            child: AppText(
              pageItems[i].description??"",
              size: 12.sp,
              maxLine: 1,
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
          Spacer(),
          PriceWidget(
            value: pageItems[i].currentPrice?[0].value,
            color: Theme.of(context).primaryColor,
            isDollar: false,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppButton(
                isLoading: false,
                isExpanded: true,
                transparent: true,
                text: "Add to cart",
                onTap: onTap,
              ),
            ],
          )
        ],
      ),
    );
  }
}
