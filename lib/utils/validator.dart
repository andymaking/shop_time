import 'string-extensions.dart';

import '../localization/locales.dart';

const emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[0-9])\w+");

String? Function(String?)? emailValidator = (String? val) {
  String validate = val!.replaceAll(RegExp(r"\s+"), "");
  if (validate.isEmpty ||
      !RegExp(emailRegex).hasMatch(validate)) {
    return 'Enter valid email';
  }
  return null; // Return null for valid input
};

String? Function(String?)? passwordValidator = (String? val) {
  String value = val??"";
  RegExp regex = RegExp(r'[A-Z]');
  RegExp smallRegex = RegExp(r"[a-z]");
  RegExp numberRegex = RegExp(r'\d');
  RegExp signRegex = RegExp(r'[!@#$%^&*(),\-_.?":;{}|<>]');
  if (value.length < 7) {
    return LocaleData.password8.convertString();
  } else if (!regex.hasMatch(value)){
    return LocaleData.passwordCapital.convertString();
  } else if (!smallRegex.hasMatch(value)){
    return LocaleData.passwordSmall;
  } else if (!numberRegex.hasMatch(value)){
    return LocaleData.passwordNumber.convertString();
  } else if (!signRegex.hasMatch(value)){
    return LocaleData.passwordSign.convertString();
  }
  return null;
};

String? Function(String?)? emptyValidator = (String? val) {
  String value = val??"";
  if(value.trim().isEmpty){
    return LocaleData.emptyField.convertString();
  }
};

bool validateFullName(String input) {
  // Regular expression pattern
  RegExp regex = RegExp(r'^[A-Za-z]{2,}(?:\s[A-Za-z]{2,})+$');

  // Test the input against the pattern
  return regex.hasMatch(input);
}

bool validateName(String input) {
  // Regular expression pattern
  RegExp regex = RegExp(r"^[A-Z][a-zA-Z'_-]+$");
  // Test the input against the pattern
  return regex.hasMatch(input);
}

bool isEightDigitPhoneNumber(String input) {
  final RegExp regex = RegExp(r'^\d{11}$');
  return regex.hasMatch(input);
}

String? validatePhoneNumber(String? value) {
  if (!isEightDigitPhoneNumber(value!)) {
    return 'Please enter a valid 8-digit phone number';
  }
  return null; // Input is valid
}

String? fullNameValidator(String? value) {
  if(value==null){
    return "Full name cannot be empty";
  }else if(validateFullName(value)){
    return "Full Name not Valid";
  }
  return null;
}

String? nameValidator(String? value) {
  if(value==null){
    return "Full name cannot be empty";
  }else if(validateName(value)){
    return "Name not Valid";
  }
  return null;
}