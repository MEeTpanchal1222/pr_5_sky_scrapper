import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modal/main_modal.dart';

class WeatherProvider with ChangeNotifier {
  WeatherResponse? _weatherResponse;
  bool _isLoading = true;

  WeatherResponse? get weatherResponse => _weatherResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String query) async {
     const String apiKey = 'fc7289896b1d4aa3be053134242506';
     const String baseUrl = 'https://api.weatherapi.com/v1/current.json';


      final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$query'));

      if (response.statusCode == 200) {
        _weatherResponse = WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
     _isLoading = false;
     notifyListeners();
    }
  Future<List<String>> getSuggestions(String query) async {
    const String apiKey = 'fc7289896b1d4aa3be053134242506';
    const String baseUrl = 'https://api.weatherapi.com/v1/current.json';
    try {
      final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$query'));
      if (response.statusCode == 200) {
        List<String> suggestions = [];
        var data = jsonDecode(response.body);
        for (var item in data) {
          suggestions.add(item['name']);
        }
        return suggestions;
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      throw Exception('Failed to fetch suggestions: $e');
    }
  }
  }

