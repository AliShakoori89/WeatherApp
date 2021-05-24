import 'package:weather/database/database.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/daily_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
// import 'package:weather/models/week_weathers_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/api_base_helper.dart';

class WeatherRepository {

  ApiBaseHelper _apiHelper = ApiBaseHelper();

  Future<WeatherModel> getWeatherWithCityName(String cityName) async {
    var weather = await _apiHelper.getWeatherDataWithCityName(cityName);
    print('xxxxxxxxxxxxxxxxxxxgetWeatherWithCityName$weather');
    return weather;
  }

  // Future<WeatherModel> getWeatherWithLocation(double latitude, double longitude) async{
  //   var weather = await _apiHelper.getCityNameFromLocation(latitude, longitude);
  //   return weather;
  // }
  //
  Future<DailyWeatherModel> getForecastForDaily (String cityName) async{

    var weathers = await _apiHelper.DailygetForecast(cityName);
    print('xxxxdailygetForecast$weathers');
    return weathers;
  }

  Future<HourlyWeatherModel> getForecastForHourly (String cityName) async{

    var weathers = await _apiHelper.HourlygetForecast(cityName);
    print('xxxxhourlygetForecast$weathers');
    return weathers;
  }

  // Future<WeekWeatherModel> getForcastWithLocation (double latitude, double longitude) async{
  //   var weather = await _apiHelper.getForecastFromLocation(latitude, longitude);
  //   return weather;
  // }

  Future<bool> saveContactRepo(CityModel cityModel) async {
    var helper = DatabaseHelper();
    return await helper.saveCityName(cityModel);
  }
}