import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/daily_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
// import 'package:weather/models/week_weathers_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class ApiBaseHelper {
  final String _baseUrl = 'http://api.openweathermap.org';
  final String apiKey = '055ef26309ce2b615edf4e5870da82d6';

  Future<WeatherModel> getCityNameFromLocation(double latitude, double longitude) async {
    final url = '$_baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    print ('fetching $url');
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
    print ('getWeatherDataWithCityName ${json.decode (res.body)}');
    if(res.statusCode != 200){
      throw FetchDataException ("unable to fetch weather data");
    }
    final weatherJson = json.decode (res.body);
    return WeatherModel.fromJson (weatherJson);
  }

  Future<DailyWeatherModel> DailygetForecast(String cityName) async {
    final url = '$_baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    final res = await http.get(Uri.parse (url));
    if (res.statusCode != 200) {
      throw FetchDataException("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    var dic = weatherJson['list'];
    var details = new Map();
    details['list'] = dic;
    print('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ$details');
    return DailyWeatherModel.fromJson(details);
  }

  Future<HourlyWeatherModel> HourlygetForecast(String cityName) async {
    final url = '$_baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    final res = await http.get(Uri.parse (url));
    if (res.statusCode != 200) {
      throw FetchDataException("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB$weatherJson');
    return HourlyWeatherModel.fromJson(weatherJson);
  }

  // Future<WeekWeatherModel> getForecastForDaily(String cityName) async {
  //   final url = '$_baseUrl/data/2.5/forecast/daily?q=$cityName&cnt=7&appid=$apiKey';
  //   // print('fetchinggg $url');
  //   final res = await http.get(Uri.parse (url));
  //   // print('getForecast${json.decode(res.body)}');
  //   if (res.statusCode != 200) {
  //     throw FetchDataException("unable to fetch weather data");
  //   }
  //   final forecastJson = json.decode(res.body);
  //   return WeekWeatherModel.fromJson(forecastJson);
  // }
}