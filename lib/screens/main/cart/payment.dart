import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptime/data/cache/app-images.dart';
import 'package:shoptime/data/cache/constants.dart';
import 'package:shoptime/data/cache/database-keys.dart';
import 'package:shoptime/data/cache/palette.dart';
import 'package:shoptime/data/repository/repository.service.dart';
import 'package:shoptime/locator.dart';
import 'package:shoptime/utils/snack_message.dart';
import 'package:shoptime/utils/widget_extensions.dart';
import 'package:shoptime/widget/apptexts.dart';
import 'package:shoptime/widget/image_builder.dart';
import 'package:shoptime/widget/success-screen.dart';
import 'package:shoptime/widget/text_field.dart';

import '../../../data/model/get-product-response.dart';
import '../../../widget/app-bar-widget.dart';
import '../../../widget/app-button.dart';
import '../bottom.nav.ui.dart';

class PaymentScreen extends StatefulWidget {
  final List<Items> products;
  final num totalPrice;
  final num discountedPrice;
  final num deliveryFee;
  final String email;
  final String phoneNumber;
  final String address;
  const PaymentScreen({super.key, required this.products, required this.totalPrice, required this.discountedPrice, required this.deliveryFee, required this.email, required this.phoneNumber, required this.address});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final formKey = GlobalKey<FormState>();

  var cardNumberController = TextEditingController();
  var cvvController = TextEditingController();
  var expiryDateController = TextEditingController();

  onChange(String? val)async{
    setState(() {});
  }

  bool isLoading = false;

  startLoading()async{
    isLoading = true;
    setState(() {});
  }

  stopLoading()async{
    isLoading = false;
    setState(() {});
  }

  pay() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoading();
    try{
      var res = await repository.createSale(
        products: widget.products,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
        address: widget.address,
        totalPrice: widget.totalPrice,
        discountedPrice: widget.discountedPrice,
        deliveryFee: widget.deliveryFee
      );
      if(res){
        stopLoading();
        navigationService.navigateToAndRemoveUntilWidget(
            SuccessScreen(
                title: "Payment Successful",
                body: "Thanks for your purchase",
                onTap: () async{
                  await storageService.deleteItem(key: StorageKey.PRODUCTS);
                  navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen(initialIndex: 2,));
                }
            )
        );
      }else{
        stopLoading();
        showCustomToast("Error making order");
      }
      stopLoading();
    }catch(err){
      print(err);
      showCustomToast("Error making order");
      stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: "Payment",
        centerTile: false,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
          children: [
            Image.asset(
              AppImages.card,
              width: width(context),
              fit: BoxFit.fitWidth,
            ),
            25.sp.sbH,
            AppTextField(
              isDark: false,
              hint: "0000 0000 0000 0000",
              hintText: "Card Number",
              onChanged: onChange,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              controller: cardNumberController,
              validator: (val){
                String value = cardNumberController.text.trim()??"";
                if(value.isEmpty){
                  return "Card Number Cannot be empty";
                }
                if(value.length < 10){
                  return "Card Number must be more than 9";
                }
                return null;
              },
            ),
            25.sp.sbH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    isDark: false,
                    hint: "MM/YY",
                    hintText: "Expiry Date",
                    onChanged: onChange,
                    keyboardType: TextInputType.number,
                    controller: expiryDateController,
                    maxLength: 5,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                      ExpiryDateInputFormatter(),
                    ],
                    validator: (val){
                      String value = expiryDateController.text.trim()??"";
                      if(value.isEmpty){
                        return "Expiry Date Cannot be empty";
                      }
                      if(value.length < 5){
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                16.sp.sbW,
                Expanded(
                  child: AppTextField(
                    isDark: false,
                    hint: "123",
                    maxLength: 3,
                    hintText: "CVV",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: onChange,
                    controller: cvvController,
                    validator: (val){
                      String value = cvvController.text.trim()??"";
                      if(value.isEmpty){
                        return "Expiry Date Cannot be empty";
                      }
                      if(value.length < 3){
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            50.sp.sbH,
            Padding(
              padding: 25.sp.padH,
              child: AppButton(
                isLoading: false,
                text: "Make Payment",
                onTap: formKey.currentState?.validate() == true? pay: null,
              ),
            ),
            60.sp.sbH,
          ],
        ),
      ),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (text.length == 2 && !text.contains('/')) {
      text = text + '/';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}