import 'package:get/get.dart';
import 'package:spotify_ui/viewmodel/validasyon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class AuthService{
  Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async{
    String path = join(await getDatabasesPath(),'Spotify.db');
    return await openDatabase(path,version: 1,onCreate: ((db, version){
      return db.execute(
        '''CREATE TABLE Kullanicilar(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,surname TEXT,email TEXT,password TEXT)''',
      );
    }
    ),
    );
  }
  Future<void> insertUser(Map<String,dynamic> user) async {
    final db = await database;
    await db.insert('Kullanicilar', user,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String,dynamic>?> loginUser(String email,String password) async{
    final db = await database;
    List<Map<String,dynamic>> results = await db.query(
      'Kullanicilar',
      where: 'email = ? AND password = ?',
      whereArgs: [email,password],
    );
    if(results.isNotEmpty){
      Map<String,dynamic> user = results.first;
       UserController userController = Get.find();
      userController.setUsername(user['name']); 
      return results.first;
    }
    return null;
  }
}