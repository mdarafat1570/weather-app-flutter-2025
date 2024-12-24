import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/utils/constants.dart';

class WeatherRepository {
  static const String _baseUrl =
      '${Constants.WEATHER_BASE_SCHEME}${Constants.WEATHER_BASE_URL_DOMAIN}';

  Future<Map<String, dynamic>> fetchWeatherData(
      {required String location}) async {
    final url = Uri.parse(
        '$_baseUrl${Constants.currentWeatherApiUrl}?key=${Constants.WEATHER_APP_ID}&q=$location');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }
}
