class DbTable {
  static const tableDiary = "diary";
  static const tablePage = "page";

  static const tables = [
    "CREATE TABLE IF NOT EXISTS " +
        tableDiary +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "type TEXT, "
            "enterCode TEXT"
            ")",
    "CREATE TABLE IF NOT EXISTS " +
        tablePage +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "date TEXT, "
            "title TEXT, "
            "content TEXT, "
            "diaryId INTEGER, "
            "FOREIGN KEY (diaryId) REFERENCES " +
        tableDiary +
        "(id)"
            ")"
  ];
}
