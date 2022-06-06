import 'package:database_example/screens/note_detail.dart';
import 'package:flutter/material.dart';

// create StatefulWidget. check how to create StatefulWidget with two classes.
class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  // for ListView.builder
  int count = 0;

  @override
  Widget build(BuildContext context) {
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
          navigateToNoteDetail('New Note');
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
            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text('Dummy Title', style: titleStyle,),
            subtitle: const Text('Dummy Date'),
            trailing: const Icon(Icons.delete, color: Colors.grey,),
            onTap: () {
              debugPrint('List Item clicked.');
              navigateToNoteDetail('Edit Note');
            },
          ),
        );
      },
    );
  }

  void navigateToNoteDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    },));

  }
}