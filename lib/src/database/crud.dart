import 'package:sqflite/sqflite.dart';
import 'package:database_test/src/database/db.dart';

abstract class Crud {
  final String table;
  const Crud(this.table);

  Future<Database> get database async {
    return await Db().open();
  }

  query(String sql, {List<dynamic>? arguments}) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  update(Map<String, dynamic> data) async {
    final db = await database;
    return await db
        .update(table, data, where: "id = ?", whereArgs: [data["id"]]);
  }

  insert(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  delete(int id) async {
    final db = await database;
    return await db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
