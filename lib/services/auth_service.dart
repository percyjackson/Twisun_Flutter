import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twisun/constants.dart';
import 'package:twisun/models/login_model.dart';
import 'package:twisun/models/user_model.dart' as userModel;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebase User
  userModel.User _userFromFirebaseUser(User user) {
    return user != null ? userModel.User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<userModel.User> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register in with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      //await DatabaseService(uid: user.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  var url = Uri.parse('$kBaseUrl/Account/CreateToken');
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    print(loginRequestModel.toJson());
    Map<String, String> header = {'Content-Type': 'application/json'};
    final response =
        await http.post(url, headers: header, body: loginRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
