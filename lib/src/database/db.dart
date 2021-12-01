import 'package:database_test/src/database/db_migration.dart';
import 'package:database_test/src/database/db_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  String name = "DiaryApp";
  int version = 1;
  Future<Database> open() async {
    String path = join(await getDatabasesPath(), name);
    return openDatabase(path,
        version: version,
        onConfigure: onConfigure,
        onCreate: onCreate,
        onUpgrade: onUpgrade);
  }
}

onCreate(Database db, int version) {
  // ignore: avoid_function_literals_in_foreach_calls
  DbTable.tables.forEach((script) async => await db.execute(script));
}

onConfigure(Database db) async {
  await db.execute("PRAGMA foreign_keys = ON");
}

onUpgrade(Database database, int oldVersion, int newVersion) async {
  if (oldVersion < newVersion) {
    // ignore: avoid_print
    print(
        "Actualizar, con la version vieja: $oldVersion y la nueva: $newVersion");
    // ignore: avoid_function_literals_in_foreach_calls
    DbMigration.migrationScripts.forEach((script) async {
      await database.execute(script);
    });
  }
}
