import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableUser = 'user';
const String columnId = '_id';
const String columLogin = 'login';
const String columnPassword = 'password';
const String columnToken = 'token';

class User {
  late int id;
  late String login;
  late String password;
  late String token;

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columLogin: login,
      columnPassword: password,
      columnId: id,
      columnToken: token
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    login = map[columLogin];
    password = map[columnPassword];
    token = map[columnToken];
  }
}

class DBProvider {
  static Database? db;

  Future<Database?> get database async {
    if (db != null) {
      return db;
    }
    db = await _initialize();
    return db;
  }

  Future<String> get fullPath async {
    const name = 'user.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
        path,
        version: 1,
        onCreate: create,
        singleInstance: true);
    return database;
  }

  Future<void> create (Database database, int version) async =>
    await createTable(database);

  Future<void> createTable(Database database) async {
    await  database.execute('''
create table $tableUser ( 
  $columnId integer primary key autoincrement, 
  $columLogin text not null,
  $columnPassword text not null,
  $columnToken text not null)
''');
  }

  Future<User> insert(User user) async {
    user.id = (await db?.insert(tableUser, user.toMap()))!;
    return user;
  }

  Future<User?> getUser(int id) async {
    final database = await DBProvider().database;
    var maps = await database?.query(
            tableUser,
            columns: [columnId, columLogin, columnPassword, columnToken],
            where: '$columnId = ?',
            whereArgs: [id]
    );

    if (maps!.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int?> delete(int id) async {
    return await db?.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future close() async => db?.close();
}
