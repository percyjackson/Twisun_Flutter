import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twisun/components/loading.dart';
import 'package:twisun/models/login_model.dart';
import 'package:twisun/screens/forgot_password/forgot_password_screen.dart';
import 'package:twisun/screens/home/home_screen.dart';
import 'package:twisun/screens/sign_in/components/service.dart';
import 'package:twisun/services/auth_service.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email;
  String password;
  bool remember = false;
  bool isLoading = false;

  LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  //sharedPreferences.setString("token", data['token']);
  //Navigator.popAndPushNamed(context, HomeScreen.routeName);
  //Navigator.pushNamedAndRemoveUntil(            context, HomeScreen.routeName, (route) => false);

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
                Text("Remember me"),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            FormErrors(errors: errors),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: "Continue",
              press: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  //TODO Login!
                  setState(() {
                    isLoading = true;
                  });
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      errors.add('Could not sign in with those credentials');
                    });
                  }
                  /*
                  AuthService authService = new AuthService();
                  requestModel.email = email;
                  requestModel.password = password;
                  */
                  /*
                  authService.login(requestModel).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value.token.isNotEmpty) {
                      print(value.token);
                    } else {
                      final snackBar = SnackBar(
                        content: Text(value.error),
                      );
                      print(value.error);
                    }
                  });
                  */
                  /*
                  var response = await logingUser(email, password);
                  if (response.containsKey('token')) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.routeName, (route) => false);
                  }
                  */
                }
              },
            )
          ],
        ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 6 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 6 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail_outline),
      ),
    );
  }
}
