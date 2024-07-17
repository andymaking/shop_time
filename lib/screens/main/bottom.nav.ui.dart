import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/cache/app-images.dart';
import '../../data/cache/palette.dart';
import '../../utils/widget_extensions.dart';
import '../../widget/apptexts.dart';
import '../base-ui.dart';
import 'bottom.nav.vm.dart';

class BottomNavigationScreen extends StatelessWidget {
  final int? initialIndex;
  const BottomNavigationScreen({super.key, this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavigationViewModel>(
      onModelReady: (m)=> m.init(initialIndex: initialIndex),
      builder: (_, model, theme, child)=> Scaffold(
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: model.screens[model.selectedPage]
            ),
            Padding(
              padding: 30.sp.padA,
              child: _BottomNavigationBar(
                onItemSelected: model.onNavigationItem,
                selectedIndex: model.selectedPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    Key? key, required this.onItemSelected, required this.selectedIndex
  }) : super(key: key);

  final Function(int) onItemSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67.sp,
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      padding: 16.0.padH,
      child: Padding(
        padding: 5.sp.padV,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                icon: AppImages.home,
                isSelected: (selectedIndex == 0),
                index: 0,
                onTap: onItemSelected,
              ),
              _NavigationBarItem(
                icon: AppImages.cart,
                isSelected: (selectedIndex == 1),
                index: 1,
                onTap: onItemSelected,
              ),
              _NavigationBarItem(
                icon: AppImages.checkOut,
                isSelected: (selectedIndex == 2),
                index: 2,
                onTap: onItemSelected,
              ),
            ]
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.icon,
    required this.index,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final String icon;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          onTap(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 40.sp ,
                width: 40.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: isSelected? Theme.of(context).primaryColor: Colors.transparent,
                ),
                child: SvgPicture.asset(
                  icon,
                  height: 24.sp, width: 24.sp,
                  color: isSelected? Colors.black: Colors.white,
                )
            ),
          ],
        ),
      ),
    );
  }
}