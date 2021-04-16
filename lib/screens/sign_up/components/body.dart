import 'package:flutter/material.dart';
import 'package:twisun/components/default_button.dart';
import 'package:twisun/components/form_error.dart';
import 'package:twisun/components/social_card.dart';
import 'package:twisun/constants.dart';
import 'package:twisun/screens/sign_up/components/sign_up_form.dart';
import 'package:twisun/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Register Account",
                  style: headingStyle,
                ),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenWidth * 0.15),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenWidth * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        //TODO Sign-Up google
                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {
                        //TODO Sign-Up facebook
                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {
                        //TODO Sign-Up twitter
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "By continuing you confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
