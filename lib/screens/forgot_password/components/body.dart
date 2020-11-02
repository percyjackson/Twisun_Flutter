import 'package:flutter/material.dart';
import 'package:twisun/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Forgot Password",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(28),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Please enter your email and we will send you \n a link to return to your account",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
