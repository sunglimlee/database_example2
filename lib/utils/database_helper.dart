import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:database_example/models/note.dart';

// Database Helper class : singletons, CRUD, RAW SQL
class DatabaseHelper {
  // singleton object of this database helper class
  // [error] The non-nullable variable '_database' must be initialized.
  // https://stackoverflow.com/questions/67049107/the-non-nullable-variable-database-must-be-initialized
  // 이 데이터베이스는 언제 사용하게 되는데??????????????
  static DatabaseHelper? _databaseHelper;

  // singleton database
  static Database? _database;

  // 향후 Enum 이나 Const 를 사용해서 상수화하자.
  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'property';
  String colDate = 'date';

  //////////////////////////////////////////////////////////////////////////////////////
  // named constructor - 다른것보다 훨씬 더 실용적이네..
  // 말그대로 constructor 이나깐 오브젝트를 만들어 내는구나. 그래서 DatabaseHelper() 오브젝트를 만드는구나.
  //https://medium.com/nerd-for-tech/named-constructor-vs-factory-constructor-in-dart-ba28250b2747
  DatabaseHelper._createInstance();

  // factory constructor allow you to return some value.
  // 기본 생성자를 사용하면서 그걸 factory 로 만들어 놓으니 새로운 static 이 없으면 named constructor 로
  // 만들고 그걸 그턴 받게 한다는 거네..
  // 그럼 DatabaseHelper databaseHelper = DatabaseHelper(); 이라고 하면 무조건 static _databaseHelper
  // 의 리턴값이 리턴되니깐 그거만 사용할 수 있다는 거네..
  factory DatabaseHelper() {
    if (_databaseHelper != null) {
      return _databaseHelper!;
    } else {
      _databaseHelper = DatabaseHelper._createInstance();
      return _databaseHelper!;
    }
    //_databaseHelper ??= DatabaseHelper._createInstance(); // means if it is null
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  // 이제부터 database 에 접근하면 무조건 null check 를 하고나서 없으면 만들어주고 null 이 아니면
  // _database 를 리턴한다. 이제 이걸 나중에 어떻게 사용할 지를 보면 알겠네... Future 가 들어가는지 않들어가는지.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initializeDatabase();
      return _database!;
    }
  }
  // Get the directory path for both Android and IOS to store database
  // getApplicationDocumentsDirectory() belongs to path_provider package
  // 함수에 return 값이 없는데도 return 을 할 수 있나?? async 때문인가?
  // initializeDatabase() is async which means it returns Future
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}notes.db';
    //Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  // create database function //여기서 async 사용
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  //아래는 CRUD 작업
  // Fetch Operation : Get all note object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database; // await database 를 해서 데이터를 그냥 사용하는군...
    //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result; // sqflite plugin only return list of map objects
  }

  // Insert Operation : Insert a Note object ot database
  Future<int> insertNote(Note note) async {
    Database db = await database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // Update Operation : Update a Note object to database
  Future<int> updateNote(Note note) async {
    var db = await database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation ; Delete a Note object ot database
  Future<int> deleteNote(int id) async {
    var db = await database;
    int result =
        await db.delete(noteTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  // Get number of Note object in database
  Future<int?> getCount() async {
    // 이렇게 한 이유가 있구나.. database 를 바로 쓸수가 없고 만들어질때 까지 기다려야 하니깐...
    // 이렇게 어느순가 쓸 수가 있네..
    // await 에서 바로 받으면 일반값을 받을 수 있나보다.
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  //Get the 'Map List', List<Map>  and convert it to 'Note List, List<Note>
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = [];
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
