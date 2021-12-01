import 'package:database_test/src/database/crud.dart';
import 'package:database_test/src/database/db_table.dart';
import 'package:sqflite/sqflite.dart';

class PageDiary extends Crud {
  int? id;
  String date;
  String title;
  String content;
  int diaryId;

  PageDiary(
      {this.id,
      this.date = "",
      this.title = "",
      this.content = "",
      this.diaryId = 0})
      : super(DbTable.tablePage);

  factory PageDiary.toObject(Map<dynamic, dynamic>? data) {
    return (data != null)
        ? PageDiary(
            id: data['id'],
            date: data['date'],
            title: data['title'],
            content: data['content'],
            diaryId: data['diaryId'],
          )
        : PageDiary();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'diaryId': diaryId
    };
  }

  getList(parsed) {
    // Convertimos lista de Map a lista de Objetos
    return (parsed as List).map((map) => PageDiary.toObject(map)).toList();
  }

  Future<List<PageDiary>> getPages(idDiary) async {
    var result = await query(
        "SELECT * FROM ${DbTable.tablePage} WHERE diaryId = ?",
        arguments: [idDiary]);
    return getList(result);
  }

  saveOrUpdate() async {
    id = (id != null) ? await update(toMap()) : await insert(toMap());

    if (id != null && id! > 0) {
      return this;
    } else {
      return null;
    }
  }

  insertPages(List<PageDiary> pages) async {
    final db = await database;
    db.transaction((database) async {
      Batch batch = database.batch();
      for (PageDiary page in pages) {
        batch.insert(table, page.toMap());
      }
      // Con "continueOnError: false" se ejecutara el callback en caso de error
      var result = await batch.commit(continueOnError: false, noResult: false);
      // ignore: avoid_print
      print("resultado: $result");
    });
  }
}
