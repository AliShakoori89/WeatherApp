import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/city_model.dart';


final table = 'my_table';

final columnId = 'id';
final columnName = 'name';

class DatabaseHelper {

  DatabaseHelper();

  static const databaseName = 'MyDatabase.db';
  static final DatabaseHelper instance = DatabaseHelper (
  );
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
              ' $columnName TEXT NOT NULL)');
    });
  }

  Future<bool> saveCityName(CityModel cityModel) async {
    var myContact = await database;
    await myContact.insert (
        CityModel.TABLENAME,cityModel.toMap (),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print ('aaaaaaaaaaaaaaaaaaaaaaa${cityModel.toMap ()}');
    return true;
  }

  Future<List> getAllContacts() async {
    var myContact = await database;
    List listMap = await myContact.rawQuery (
        'SELECT * FROM my_table');
    var listContact = <CityModel>[];
    for (Map m in listMap) {
      listContact.add (CityModel.fromMap (m));
    }
    return listContact;
  }

  getContact(int id) async {
    var myContact = await database;
    var result = await myContact.query ("my_table", where:"$columnId=?",whereArgs: [id]);
    print(result);
    return  CityModel.fromMap (result.first) ;
  }

  Future close() async {
    var myContact = await instance.database;
    return myContact.close (
    );
  }

  Future<int> deleteContact(int id) async {
    print("id is too delete");
    print(id);
    var dbContact = await database;
    return await dbContact.delete("my_table", where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> isFavorite(CityModel contact) async {
    var dbContact = await database;
    return await dbContact.update("my_table", contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<int> updateContact(CityModel contact) async {
    print('database ${contact.id}');
    var dbContact = await database;
    return await dbContact.update("my_table", contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<List> fetchFavorite() async {
    var myContact = await database;
    List listMap = await myContact.rawQuery (
        'SELECT * FROM my_table WHERE favorite = ?', ['1']);
    print('listMap====== $listMap');
    var listContact = <CityModel>[];
    for (Map m in listMap) {
      listContact.add (CityModel.fromMap (m));
    }
    return listContact;
  }
}


