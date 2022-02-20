import 'package:shared_preferences/shared_preferences.dart';

class CityTemporaryMemory{

  savedCity(String cName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('City_Name', cName);
  }

  fetchCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cityName = prefs.getString('City_Name');
    return cityName;
  }

  clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}