import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/data/cache/palette.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../widget/app-bar-widget.dart';
import '../../../widget/app-button.dart';
import 'payment.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  String? selectedAddress;

  selectAddress(String address){
    selectedAddress = address;
    setState(() {});
  }

  List<String> addresses = [
    "Old Secretariat Complex, Area 1, Garki Abaji Abji",
    "Sokoto Street, Area 1, Garki Area 1 AMAC"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: "Checkout",
        centerTile: false,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
        children: [
          AppText(
            "Select how to receive your package(s)",
            size: 16.sp,
            weight: FontWeight.w600,
          ),
          16.sp.sbH,
          const AppText(
            "Pickup",
            weight: FontWeight.w500,
          ),
          16.sp.sbH,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addresses.length,
            itemBuilder: (_, i){
              return Padding(
                padding: 15.sp.padB,
                child: Row(
                  children: [
                    MyRadio(
                      value: selectedAddress == addresses[i],
                      onTap:()=> selectAddress(addresses[i])
                    ),
                    AppText(
                      addresses[i],
                      size: 12.sp,
                      color: textColor.withOpacity(0.5),
                      align: TextAlign.start,
                    )
                  ],
                ),
              );
            }
          ),
          25.sp.sbH,
          AppText(
            "Delivery",
            weight: FontWeight.w500,
          ),
          10.sp.sbH,
          TextArea(
            maxLines: 2,
          ),
          25.sp.sbH,
          AppText(
            "Contact",
            weight: FontWeight.w500,
          ),
          10.sp.sbH,
          Row(
            children: [
              SizedBox(
                width: width(context)*0.65,
                child: TextArea(
                  maxLines: 1,
                  hintText: "Phone nos 1",
                ),
              ),
            ],
          ),
          16.sp.sbH,
          Row(
            children: [
              SizedBox(
                width: width(context)*0.65,
                child: TextArea(
                  maxLines: 1,
                  hintText: "Phone nos 2",
                ),
              ),
            ],
          ),
          60.sp.sbH,
          Padding(
            padding: 25.sp.padH,
            child: AppButton(
              isLoading: false,
              text: "Go to Payment",
              onTap: selectedAddress == null? null: ()=> navigationService.navigateToWidget(const PaymentScreen()),
            ),
          ),
          60.sp.sbH,
        ],
      ),
    );
  }
}


class MyRadio extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;
  const MyRadio({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: 16.sp.padR,
        height: 20.sp,
        width: 20.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.sp, color: value? Theme.of(context).primaryColor : textColor.withOpacity(0.5))
        ),
        child: value? Icon(Icons.circle, size: 8.sp, color: primaryColor,) :null,
      ),
    );
  }
}
