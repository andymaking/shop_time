class AppCache {

  clearCheckoutData(){
    totalAmount = 0.0;
    quantityOfItems = 0;
  }

  bool? firstTimeKYC;

  double totalAmount = 0.0;
  String chatID = "";
  int quantityOfItems = 0;
  int initialIndex = 0;
  bool isEdit = false;


  String? dateOfBirth;



  String? otp;
  String? emailOtp;
  String? phone;
  String? forgotEmailType;
  AuthModel authModel = AuthModel();

  clearAuth(){
    authModel = AuthModel();
  }

}

class AuthModel{
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? code;
  String? email;
  String? otp;
  String? pin;

  AuthModel({
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.code,
    this.email,
    this.otp,
    this.pin,
  });
}