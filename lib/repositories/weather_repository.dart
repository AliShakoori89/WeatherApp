import 'package:location/location.dart';
import 'package:weather/database/database.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/api_base_helper.dart';
import 'package:geolocator/geolocator.dart' as Geo;

class WeatherRepository {

  ApiBaseHelper _apiHelper = ApiBaseHelper();

  Future<WeatherModel> getWeatherWithCityName(String cityName) async {
    var weather = await _apiHelper.getWeatherDataWithCityName(cityName);
    return weather;
  }

  Future<WeatherModel> getCityNameFromLocation(double lat, double lon) async {
    var weather = await _apiHelper.getCityNameFromLocation(lat, lon);
    return weather;
  }

  Future<WeatherDetailsModel> getForecastForHourlyWithCityName (String cityName) async{

    var weathers = await _apiHelper.HourlygetForecastWithCityName(cityName);
    return weathers;
  }

  Future<WeatherDetailsModel> getForecastForHourlyWithCityLocation (double lat, double lon) async{

    var weathers = await _apiHelper.HourlygetForecastWithCityLocation(lat, lon);
    return weathers;
  }

  Future<bool> saveCityWeatherDetailesRepo(CityModel cityModel) async {
    var helper = DatabaseHelper();
    return await helper.saveCityName(cityModel);
  }

  Future<int> deleteCityWeatherDetailesRepo(String name) async {
    var helper = DatabaseHelper();
    return await helper.deleteContact(name);
  }

  Future updateCityWeatherRepo(CityModel cityModel) async {
    var helper = DatabaseHelper();
    return await helper.updateCityWeather(cityModel);
  }

  Future<List> fetchAllDataCityWeatherRepo() async {
    var helper = DatabaseHelper();
    return await helper.getAllCityWeather();
  }

  Future<Geo.Position> fetchCityLocationRepo() async{

    final Location location = Location();
    bool serviceStatusResult = await location.requestService();

     if (serviceStatusResult){
       var position = await Geo.Geolocator.getCurrentPosition();
       return position;

    }
  }
}