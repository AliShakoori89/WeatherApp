import 'package:weather/database/database.dart';

class CityModel {
  int id;
  String name;
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  String icon;
  int time;

  CityModel(
      { this.id, this.name, this.icon, this.temp,
      this.tempMin, this.tempMax, this.feelsLike, this.time});

  static const String TABLENAME = "my_table";

  CityModel.Map(dynamic CityModel) {
    this.id = CityModel['id'];
    this.name = CityModel['name'];
    this.feelsLike = CityModel['feelsLike'];
    this.tempMax = CityModel['tempMax'];
    this.tempMin = CityModel['tempMin'];
    this.icon = CityModel['icon'];
    this.time = CityModel['time'];
    this.temp = CityModel['temp'];
  }

  CityModel.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
    icon = map[columnIcon];
    tempMin = map[columnTempMin];
    tempMax = map[columnTempMax];
    temp = map[columnTemp];
    feelsLike = map[columnFeelsLike];
    time = map[columnTime];
  }

  CityModel.MaptoObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    icon = map['icon'];
    tempMin = map['tempMin'];
    tempMax = map['tempMax'];
    feelsLike = map['feelsLike'];
    time = map['time'];
    temp = map['temp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon' : icon,
      'tempMin' : tempMin,
      'tempMax' : tempMax,
      'feelsLike' : feelsLike,
      'time' : time,
      'temp' : temp
    };
  }
}
