import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twisun/models/user_location.dart';
import 'package:twisun/models/weather_model.dart';

class WeatherService {
  final http.Client client;
  String units = 'metric';
  String apiKey;
  WeatherService({this.client});

  void setUnits(String units) {
    this.units = units;
  }

  Future getApiKey() async {
    final pref = await SharedPreferences.getInstance();
    apiKey = pref.getString('weather_key');
    if (apiKey == null) {
      RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: Duration(hours: 1));
      await remoteConfig.activateFetched();
      apiKey = remoteConfig.getValue('weather_key').asString();
      await pref.setString('weather_key', apiKey);
    }
  }

  Future<WeatherModel> getWeather(UserLocation result) async {
    String url;
    if (result != null) {
      url =
          'http://api.openweathermap.org/data/2.5/onecall?lat=${result.latitude}&lon=${result.longitude}&appid=$apiKey&exclude=minutely,alerts&units=$units';
    } else {
      url =
          'http://api.openweathermap.org/data/2.5/onecall?lat=6.25&lon=-75.56&appid=$apiKey&exclude=minutely,alerts&units=metric';
    }

    final response = await client.get(url);

    WeatherModel req = WeatherModel.fromJson(json.decode(response.body));
    return req;
  }
}
