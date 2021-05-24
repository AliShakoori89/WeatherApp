
import 'package:weather/database/database.dart';

class CityModel {
  int id;
  String name;

  CityModel(
      { this.id,
         this.name});

  static const String TABLENAME = "my_table";

  CityModel.Map(dynamic Contact) {
    this.id = Contact['id'];
    this.name = Contact['name'];
  }

  CityModel.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
  }

  CityModel.MaptoObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
