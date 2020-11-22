import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twisun/constants.dart';
import 'package:twisun/models/login_model.dart';

class AuthService {
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
