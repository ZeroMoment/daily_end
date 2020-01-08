import 'package:daily_end/model/todo_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final String tableName = "table_todo";
  final String historyTableName = "table_todo_history";
  final String columnId = "id";
  final String columnName = "todoName";
  final String columnSub = "todoSub";
  final String cloumnTime = "todoTime";
  final String columnState = "todoState";
  final String cloumnType = "todoType";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'daily.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate); //, onUpgrade: _onUpgrade
    return ourDb;
  }

  //创建数据库表
  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    _createTableCompanyV1(batch);
//    _updateTableCompanyV1toV2(batch);

    await batch.commit();

  }

//  void _onUpgrade(Database db, int oldversion, int newVersion) async {
//    var batch = db.batch();
//    if(oldversion == 1) {
//      _updateTableCompanyV1toV2(batch);
//    }
//
//    await batch.commit();
//  }

  ///创建数据库--初始版本
  void _createTableCompanyV1(Batch batch) {
    batch.execute(
      "create table $tableName($columnId integer primary key,$columnName text not null ,$columnSub text not null ,$cloumnTime integer not null ,$columnState integer not null ,$cloumnType integer not null )",
    );
  }

//  ///更新数据库Version: 1->2.
//  void _updateTableCompanyV1toV2(Batch batch) {
////    batch.execute('ALTER TABLE $tableName ADD $columnIsSelect BOOL');
//    batch.execute("create table $historyTableName($columnId integer primary key,$columnName text not null ,$columnSub text not null ,$cloumnTime integer not null ,$columnState integer not null ,$cloumnType integer not null )");
//  }


//插入
  Future<int> saveItem(TodoData todoData) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", todoData.toMap());
    print(res.toString());
    return res;
  }

  //查询
  Future<List> getTotalList() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName");
    return result.toList();
  }

  Future<List> getTotalListRevers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return result.toList();
  }

  //查询总数
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableName"
    ));
  }

//按照id查询
  Future<TodoData> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return TodoData.fromMap(result.first);
  }


  //清空数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }


  //根据id删除
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: "$columnId = ?", whereArgs: [id]);
  }

  //修改
  Future<int> updateItem(TodoData user) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  //关闭
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
