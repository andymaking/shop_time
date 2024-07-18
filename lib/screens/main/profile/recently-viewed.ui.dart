import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../widget/app-bar-widget.dart';
import '../../base-ui.dart';
import '../home/home.ui.dart';
import 'profile-home.vm.dart';

class RecentlyViewedScreen extends StatelessWidget {
  const RecentlyViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      onModelReady: (m)=> m.getRecentViewed(),
      builder: (_, model, theme, child)=> Scaffold(
        appBar: const AppBars(
          text: "Recently Viewed",
        ),
        body: Padding(
          padding: 16.sp.padH,
          child: Column(
            children: [
              AppTextField(
                isDark: theme.isDark,
                controller: model.searchController,
                onChanged: model.onChangeSearch,
                hint: "Search",
              ),
              16.sp.sbH,
              Expanded(
                child: model.searchedRecentlyViewedItems.isEmpty?
                const Center(
                  child: AppText("No Recently viewed product"),
                ):
                GridView.builder(
                    itemCount: model.searchedRecentlyViewedItems.length,
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
                        pageItems: model.searchedRecentlyViewedItems,
                        i: i,
                        onTap: ()=> model.addToCart(model.searchedRecentlyViewedItems[i]),
                        goToDetails: ()=> model.goToDetails(model.searchedRecentlyViewedItems[i]),
                      );
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
