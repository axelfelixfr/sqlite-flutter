// ignore_for_file: unnecessary_this

import 'package:database_test/src/database/crud.dart';
import 'package:database_test/src/database/db_table.dart';

class Diary extends Crud {
  int? id;
  String type;
  String enterCode;

  Diary({this.id, this.type = "", this.enterCode = ""})
      : super(DbTable.tableDiary);

  factory Diary.toObject(Map<dynamic, dynamic>? data) {
    return (data != null)
        ? Diary(
            id: data['id'], type: data['type'], enterCode: data['enterCode'])
        : Diary();
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'type': type, 'enterCode': enterCode};
  }

  getList(parsed) {
    // Convertimos lista de Map a lista de Objetos
    return (parsed as List).map((map) => Diary.toObject(map)).toList();
  }

  save() async {
    this.id = await insert(this.toMap());
    if (this.id != null && this.id! > 0) {
      return this;
    } else {
      return null;
    }
  }

  Future<List<Diary>> getDiaries() async {
    var result = await query("SELECT * FROM ${DbTable.tableDiary}");
    return getList(result);
  }

  checkEnterCode(String enterCode) async {
    var result = await query(
        "SELECT * FROM ${DbTable.tableDiary} WHERE id = ? AND enterCode = ?",
        arguments: [this.id, enterCode]);

    // Como solo se recibira solo un item
    // Se convierte a un objeto con toObject mandando como argumento el resultado
    return Diary.toObject(result[0]);
  }
}
