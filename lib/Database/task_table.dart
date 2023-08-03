import 'package:sqflite/sqflite.dart';
import 'insert_function.dart';
import 'models/task_model.dart';

class TaskTable {
  Future<Database> db;

  TaskTable(this.db);

  static String tableName = 'task';
  static String id = 'id';
  static String title = 'title';
  static String description = 'description';
  static String date = 'date';
  static String time = 'time';
  static String color = 'color';
  static String status = 'status';

  static String createTable() => "CREATE TABLE IF NOT EXISTS"
      " $tableName ( $id int NOT null UNIQUE  , "
      " $title TEXT, $description  varchar(150) ,"
      " $date  varchar(50) null , $time varchar(200) null , "
      " $color varchar(150) null , $status varchar(150) null  ) "
      "";

  Future create(List<TaskModel> task) async {
    var connection = await db;

    connection.transaction((txn) async {
      var batch = txn.batch();

      for (var element in task) {
        var selects =
            " INSERT OR REPLACE INTO ${initInsert(tableName, element.toJson())} ";

        batch.rawQuery(selects);
        print(selects);
      }
      await batch.commit(noResult: true);
    });
  }

  Future createCustomer(TaskModel customer) async {
    var connection = await db;

    connection.transaction((txn) async {
      var batch = txn.batch();

      var selects =
          " INSERT OR REPLACE INTO ${initInsert(tableName, customer.toJson())} ";

      batch.rawQuery(selects);
      await batch.commit(noResult: true);
    });
  }

  Future<List> selectAll() async {
    var connection = await db;

    List list = [];
    list = await connection.rawQuery("SELECT * FROM $tableName");

    return list.toList();
  }

  Future<int> countTotal() async {
    var connection = await db;

    List list = [];
    list = await connection.rawQuery("SELECT $id FROM $tableName");
    return list.length;
  }



  Future<int> deleteCustomer(int id) async {
    var connect = await db;

    int result =
        await connect.delete(tableName, where: '$id =? ', whereArgs: [id]);

    return result;
  }

  Future<int> deleteAll() async {
    // Storages.remove(AppKey.customersColor);
    var connect = await db;
    int result = await connect.delete(tableName);
    return result;
  }
}
