import 'package:flutter/material.dart';
import 'package:test_flutter/models/days_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices with ChangeNotifier {
  static const String _appKey = 'add6e58cd2003670d1d339a7b452e018';
  static const String _baseUrl = 'api.weatherunlocked.com';
  static const String _appId = '71a16307';
  static const String _location = '-32.8905981,-68.8465206'; // Hyatt hotel
  List<Day> days = [];

  WeatherServices() {
    loadWeather();
  }
  Future loadWeather() async {
    final url = Uri.http(_baseUrl,'api/forecast/$_location',{
      'app_id' : _appId,
      'app_key' : _appKey
    });
    final response = await http.get(url);
    final nowWeather = Days.fromJson(response.body);
    days = nowWeather.days;
  }

}