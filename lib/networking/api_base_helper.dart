import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';


class ApiBaseHelper {
  final String _baseUrl = 'https://api.openweathermap.org';
  final String apiKey = 'dec3d08a8e81fa597d45447e05571e04';

  Future<WeatherModel> getCityNameFromLocation(double latitude, double longitude) async {
    final url = '$_baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    final res = await http.get (Uri.parse (url));
    if(res.statusCode != 200){
      throw FetchDataException ("unable to fetch weather data");
    }
    final weatherJson = json.decode (res.body);
    return WeatherModel.fromJson (weatherJson);
  }

  Future<WeatherModel> getWeatherDataWithCityName(String cityName) async {
    final url = '$_baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';

    final res = await http.get (Uri.parse (url));
    if(res.statusCode != 200){
      throw FetchDataException ("unable to fetch weather data");
    }
    final weatherJson = json.decode (res.body);
    return WeatherModel.fromJson (weatherJson);
  }

  Future<WeatherDetailsModel> HourlygetForecastWithCityName(String cityName) async {
    final url = '$_baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    final res = await http.get(Uri.parse (url));
    if (res.statusCode != 200) {
      throw FetchDataException("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return WeatherDetailsModel.fromJson(weatherJson);
  }

  Future<WeatherDetailsModel> HourlygetForecastWithCityLocation (double latitude, double longitude) async {
    final url = '$_baseUrl/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey';
    final res = await http.get(Uri.parse (url));
    if (res.statusCode != 200) {
      throw FetchDataException("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return WeatherDetailsModel.fromJson(weatherJson);
  }
}