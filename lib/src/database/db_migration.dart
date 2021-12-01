import 'package:database_test/src/database/db_table.dart';

class DbMigration {
  static const migrationScripts = [
    "ALTER TABLE ${DbTable.tableDiary} ADD COLUMN color TEXT;"
  ];
}
