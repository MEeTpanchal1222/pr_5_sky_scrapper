import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modal/main_modal.dart';

Future<WeatherResponse> fetchWeather() async {
  final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=fc7289896b1d4aa3be053134242506&q=vadodar'));

  if (response.statusCode == 200) {
    return WeatherResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}
