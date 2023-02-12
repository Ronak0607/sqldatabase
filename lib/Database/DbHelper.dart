import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkdatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await creatdatabase();
    }
  }

  Future<Database> creatdatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "demo.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT)";
      db.execute(query);
    });
  }

  Future<void> insertata(String n1, String m1) async {
    db = await checkdatabase();
    db!.insert("std", {
      "name": n1,
      "mobile": m1,
    });
  }

  Future<List<Map>> readdata() async {
    db = await checkdatabase();
    String query = "SELECT * FROM std";
    List<Map> studentlist = await db!.rawQuery(query, null);

    return studentlist;
  }

  Future<void> deletdata(String id) async {
    db = await checkdatabase();
    db!.delete("std", where: "id=?", whereArgs: [int.parse(id)]);
  }

  Future<void> editdata(String id, String n1, String m1) async {
    db = await checkdatabase();
    // db!.delete("std", where: "id=?", whereArgs: [int.parse(id)]);
    db!.update("std", {"name": n1, "mobile": m1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }
}
