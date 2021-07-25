import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/city_model.dart';


final table = 'my_table';

final columnId = 'id';
final columnName = 'name';
final columnTemp = 'temp';
final columnIcon = 'icon';
final columnTempMax = 'tempMax';
final columnTempMin = 'tempMin';
final columnFeelsLike = 'feelsLike';
final columnTime = 'time';

class DatabaseHelper {

  DatabaseHelper();

  static const databaseName = 'MyDatabase.db';
  static final DatabaseHelper instance = DatabaseHelper ();
  static Database _database;


  Future<Database> get database async {
    if(_database == null){
      return await _initDatabase (
      );
    }
    return _database;
  }

  _initDatabase() async {
    return await openDatabase (
        join (
            await getDatabasesPath (
            ),databaseName),
        version: 1,onCreate: (Database db,int version) async {
      await db.execute (
          'CREATE TABLE $table ( '
              ' $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'
              ' $columnName TEXT NOT NULL ,'
              ' $columnFeelsLike REAL ,'
              ' $columnIcon TEXT ,'
              ' $columnTemp REAL ,'
              ' $columnTempMax REAL ,'
              ' $columnTempMin REAL ,'
              ' $columnTime INTEGER)');
    });
  }

  Future<bool> saveCityName(CityModel cityModel) async {
    var myCityDB = await database;
    await myCityDB.insert ("my_table", cityModel.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List> getAllCityWeather() async {
    var myCityDB = await database;
    List listMap = await myCityDB.rawQuery (
        'SELECT * FROM my_table');
    var listCityWeather = <CityModel>[];
    for (Map m in listMap) {
      listCityWeather.add (CityModel.fromMap (m));
    }
    return listCityWeather;
  }

  Future<CityModel> fetchCityName(int id) async {
    var myCityDB = await database;
    var result = await myCityDB.query ("my_table", where:"id = ?",whereArgs: [id]);
    return CityModel.fromMap(result.first);
  }

  Future close() async {
    var myCityDB = await instance.database;
    return myCityDB.close (
    );
  }

  Future<int> deleteContact(String name) async {
    print("id is too delete");
    print(name);
    var myCityDB = await database;
    return await myCityDB.delete("my_table", where: '$columnName = ?', whereArgs: [name]);
  }

  Future<int> isFavorite(CityModel contact) async {
    var myCityDB = await database;
    return await myCityDB.update("my_table", contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<int> updateCityWeather(CityModel cityModel) async {
    var myCityDB = await database;
    return await myCityDB.update("my_table", cityModel.toMap(),
        where: '$columnName = ?', whereArgs: [cityModel.name]);
  }

  Future<List> fetchFavorite() async {
    var myCityDB = await database;
    List listMap = await myCityDB.rawQuery (
        'SELECT * FROM my_table WHERE favorite = ?', ['1']);
    var listContact = <CityModel>[];
    for (Map m in listMap) {
      listContact.add (CityModel.fromMap (m));
    }
    return listContact;
  }
}


