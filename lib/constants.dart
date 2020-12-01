import 'package:flutter/material.dart';

const String kBaseUrl = 'https://twisun.azurewebsites.net';

const kPrimaryColor = Color(0xFF171443);
const kPrimaryLightColor = Color(0xFF232257);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF171443), Color(0xFF232257)],
// );
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF979797); //0xFFdcdcdc

const kAnimationDuration = Duration(milliseconds: 200);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
