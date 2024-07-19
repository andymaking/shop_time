import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/app-card.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../data/cache/network_config.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/apptexts.dart';
import '../../base-ui.dart';
import '../cart/cart.ui.dart';
import '../home/product-details/product-detail.dart';
import 'profile-home.vm.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      onModelReady: (m)=> m.getSavedItems(),
      builder: (_, model, theme, child)=> Scaffold(
        appBar: const AppBars(
          text: "Saved Products",
        ),
        body: Padding(
          padding: 16.sp.padH,
          child: Column(
            children: [
              AppTextField(
                isDark: theme.isDark,
                controller: model.searchSavedController,
                onChanged: model.onChangeFilter,
                hint: "Search",
              ),
              16.sp.sbH,
              Expanded(
                child: model.searchedSavedItems.isEmpty?
                const Center(
                  child: AppText("No Saved product"),
                ):
                ListView.builder(
                    itemCount: model.searchedSavedItems.length,
                    itemBuilder: (_,i){
                      return AppCard(
                        onTap: ()=> model.goToDetails(model.searchedSavedItems[i]),
                        bordered: true,
                        padding: 0.0.padA,
                        margin: 10.sp.padB,
                        child: Row(
                          children: [
                            Hero(
                              tag: model.searchedSavedItems[i].photos?.first.url??"",
                              child: Container(
                                alignment: Alignment.center,
                                padding: 20.sp.padA,
                                height: width(context)*0.4,
                                width: width(context)*0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.sp),
                                    color: Theme.of(context).colorScheme.secondary
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: NetworkConfig.IMAGES_URL+(model.searchedSavedItems[i].photos?.first.url??""),
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
                                    tag: "title/${model.searchedSavedItems[i].name??""}",
                                    child: AppText(
                                      model.searchedSavedItems[i].name??"",
                                      size: 11.sp,
                                      weight: FontWeight.w600,
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  10.sp.sbH,
                                  Hero(
                                    tag: "title/${model.searchedSavedItems[i].description??""}",
                                    child: AppText(
                                      model.searchedSavedItems[i].description??"",
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
                                  10.sp.sbH,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      NewIconButtons(
                                        icon: Icon(
                                          model.savedItems.any((element) => element.id == model.searchedSavedItems[i].id)?
                                          CupertinoIcons.heart_fill: CupertinoIcons.heart,
                                          color: model.savedItems.any((element) => element.id == model.searchedSavedItems[i].id)? Colors.red: null,
                                        ),
                                        onTap: ()=> model.savedItems.any((element) => element.id == model.searchedSavedItems[i].id)? model.removeBookMark(model.searchedSavedItems[i]): model.addBookMark(model.searchedSavedItems[i]),
                                      ),
                                      NewIconButtons(
                                        iconImage: AppImages.cart,
                                        onTap: ()=> model.addToCart(model.searchedSavedItems[i]),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            10.sp.sbW
                          ],
                        ),
                      );

                      // ProductCard(
                      //   pageItems: model.searchedSavedItems,
                      //   i: i,
                      //   onTap: ()=> model.addToCart(model.searchedSavedItems[i]),
                      //   goToDetails: ()=> model.goToDetails(model.searchedSavedItems[i]),
                      // );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
