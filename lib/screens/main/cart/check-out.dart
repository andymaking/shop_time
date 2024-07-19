import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/data/cache/palette.dart';
import 'package:shoptime/utils/string-extensions.dart';
import 'package:shoptime/utils/validator.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../data/model/get-product-response.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/app-button.dart';
import 'payment.dart';

class CheckOutScreen extends StatefulWidget {
  final List<Items> products;
  final num totalPrice;
  final num discountedPrice;
  final num deliveryFee;
  final num pay;
  const CheckOutScreen({super.key, required this.products, required this.totalPrice, required this.discountedPrice, required this.deliveryFee, required this.pay});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  String? selectedAddress;

  selectAddress(String address){
    selectedAddress = address;
    setState(() {});
  }

  bool validPhone = false;
  String phoneNumber = "";
  String finalPhoneNumber = "";

  checkValidState(String val){
    if(val.contains("+234") && val.length == 14){
      validPhone = true;
    }else{
      validPhone = false;
    }
    setState(() {});
  }

  final formKey = GlobalKey<FormState>();

  onEmailChange(String? val){
    formKey.currentState!.validate();
    setState(() {});
  }

  onPhoneChange(String? val)async{
    phoneNumber = transformPhoneNumber(phoneController.text.trim().trimSpaces()??"");
    finalPhoneNumber = countryCode+phoneNumber;
    checkValidState(finalPhoneNumber);
    formKey.currentState!.validate();
    setState(() {});
  }

  goToPayment(){
    navigationService.navigateToWidget(PaymentScreen(
      products: widget.products,
      totalPrice: widget.totalPrice,
      discountedPrice: widget.discountedPrice,
      deliveryFee: widget.deliveryFee,
      pay: widget.pay,
      email: emailController.text.trim(),
      address: selectedAddress??"",
      phoneNumber: finalPhoneNumber,
    ));
  }

  List<String> addresses = [
    "Old Secretariat Complex, Area 1, Garki Abaji Abji",
    "Sokoto Street, Area 1, Garki Area 1 AMAC"
  ];

  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  String countryCode = "";

  getCountryCode(String? val)async{
    countryCode = val??"";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: "Checkout",
        centerTile: false,
      ),
      body: Form(
        key: formKey,
        child: ListView(
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
            const AppText(
              "Contact",
              weight: FontWeight.w500,
            ),
            10.sp.sbH,
            AppTextField(
              isDark: false,
              controller: emailController,
              validator: emailValidator,
              hint: "email address",
              onChanged: onEmailChange,
            ),
            10.sp.sbH,
            CustomPhoneNumberInput(
              controller: phoneController,
              hint: "Phone Number",
              onInputChanged: (val){
                getCountryCode(val.dialCode);
                onPhoneChange(val.phoneNumber);
              },
              validator: (val){
                String value = transformPhoneNumber(phoneController.text.trim().trimSpaces()??"");
                if(value.length != 10){
                  return "Invalid Phone Number";
                }
                return null;
              },
            ),
            60.sp.sbH,
            Padding(
              padding: 25.sp.padH,
              child: AppButton(
                isLoading: false,
                text: "Go to Payment",
                onTap: selectedAddress != null && formKey.currentState?.validate()== true? goToPayment: null,
              ),
            ),
            60.sp.sbH,
          ],
        ),
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
