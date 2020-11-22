import 'package:http/http.dart' as http;
import 'dart:convert';

Future logingUser(String email, String password) async {
  var url = Uri.parse('https://twisun.azurewebsites.net/Account/CreateToken');
  var body = jsonEncode({'userName': email, 'password': password});
  Map<String, String> header = {'Content-Type': 'application/json'};
  final response = await http.post(url, headers: header, body: body);
  if (response.body.isNotEmpty) {
    var data = jsonDecode(response.body);
    return data;
  }
  return response;
}
