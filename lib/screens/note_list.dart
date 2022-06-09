import 'package:database_example/models/note.dart';
import 'package:database_example/screens/note_detail.dart';
import 'package:database_example/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

// create StatefulWidget. check how to create StatefulWidget with two classes.
// [error] This class (or a class that this class inherits from) is marked as '@immutable', but one or more of its instance fields aren't final: NoteList.noteList
// 그냥 여기에다가 변수 만들지 마라... 왜냐고? StatefulWidget 이니깐.. 아니면 전부 final 로 해야한다.
class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {

  // 여기에서 변수를 만드니 아무문제 없네.. 왜냐면 여기는 StatelessWidget 도 StatefulWidget 도 아니니깐
  DatabaseHelper databaseHelper = DatabaseHelper();
  // list<Note> 를 반드시 가지고 있어야지 데이터를 다룰 수 있다.
  // [error] This class (or a class that this class inherits from) is marked as '@immutable', but one or more of its instance fields aren't final: NoteList.noteList
  // final 해도 adding 은 가능 List.add('c'). not list = ['apple']
  // [error] LateInitializationError: Field 'noteList' has not been initialized. 실행시킬때
  // late 를 없애니깐 해결되었다.
  List<Note>? noteList;
  // for ListView.builder
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // 여기에 noteList 객체를 만드는 이유는 새로 화면에 그릴때 마다 새로운 데이터로 갱신할 수 있게 하도록 함..
    // [error] The default 'List' constructor isn't available when null safety is enabled.
    // List() 가 deprecated 되었다고 해서 이렇게 사용해 본다.
    // [error] The operand can't be null, so the condition is always false.
    //
    if (noteList == null) {
      noteList = <Note>[];
      debugPrint("노트리스트가 생성되었습니다.");
      updateListView();
    } else {
      debugPrint("노트리스트가 존재합니다.");
    }

    // check each screen has it's own Scaffold
    return Scaffold(
      // Scaffold has appBar
      appBar: AppBar(
        title: const Text('Note List'),
      ),
      body: getNoteListView(),
      // Scaffold has floatingActionButton, FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating Action Button Clicked');
          //화면이동, navigate screen
          navigateToNoteDetail(Note('', '', 2, ''), 'New Note');
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    // define TextStyle for Listview which is from context Theme
    TextStyle? titleStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;
    // check how to build memory efficient ListView with builder method
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        // Card Widget for ListTile of ListView
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            // a circle that represents a user
            // [error] Invalid constant value.
            // const 를 지워주어라..
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList![position].priority), // 아이콘 색깔 바꾸고
              child: getPriorityIcon(noteList![position].priority), // 아이콘 모양 바꾸고
            ),
            // 전부 position 에 의해 값을 지정하고 있다
            title: Text(noteList![position].title, style: titleStyle,),
            subtitle: Text(noteList![position].date),
            // Flutter 에서 eventHandler 가 필요할 땐 GestureDetector 사용
            trailing: GestureDetector(
                onTap: () {
                  _delete(context, noteList![position]);
                },
                child: const Icon(Icons.delete, color: Colors.grey,),
            ),
            onTap: () {
              debugPrint('List Item clicked.');
              navigateToNoteDetail(noteList![position],'Edit Note');
            },
          ),
        );
      },
    );
  }
  // leading icon 의 priority 에 따라 color 를 바꾸어 주는 함수
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default :
        return Colors.yellow;
    }
  }
  // leading icon 의 priority 에 따라 Icon 을 바구어 주는 함수
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
      case 2:
        return const Icon(Icons.keyboard_arrow_right);
      default :
        return const Icon(Icons.keyboard_arrow_right);
    }
  }
  // delete 아이콘을 눌렀을 때 자료가 지워지는 기능을 한다.
  // 아마도 위치값을 가지고 있어야 하지 않을까?
  void _delete(BuildContext context, Note note) async {
    ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
    const snackBar = SnackBar(content: Text('Note delete successfully'),);
    int result = await databaseHelper.deleteNote(note.id!);
    if (result != 0)  {
      // [error] Do not use BuildContexts across async gaps.
      //_showSnackBar(context, 'Note deleted successfully');
      // solution(해결책은 위에처럼 ScaffoldMessengerState 잡아놓고)
      scaffoldMessengerState.showSnackBar(snackBar);
      //update the ListView. 데이터 지우고 나서 다시 update 를 하자.
      updateListView();
    }
  }
  // 이제 EditNote 나 NewNote 를 위해서 여기서 작업한다. 당연히 Note 를 넘겨주어야 겠지.
  // 여기가 마치 resultActivity 같은 역할을 하는구나.
  void navigateToNoteDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    },));
    if (result == true) {
      updateListView();
    }
  }

/*
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message),);
    // [error] The method 'showSnackBar' isn't defined for the type 'ScaffoldState'.
    // Scaffold.of(context).showSnackBar(snackBar); showSnackBar deprecated 없어졌다.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
*/

  // 업데이트 하는건 좋은데 singleton 으로 벌서 만들어져 있는데 왜 initializeDatabase() 또 부르는 걸까?
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // Future 값이 정상적으로 Database 로 받아지면...
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      // 이제 다 받아졌으면 setState() 를 실행 시킨다.
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}