import 'package:database_example/screens/note_list.dart';
import 'package:flutter/material.dart';

// check with ABOUT_DATABASE.MD file first
void main() {
  // inflate Widget
  runApp(const MyApp());
}

// create StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // has to override build method
  @override
  Widget build(BuildContext context) {
    // return MaterialApp for Google Material Theme for entire Screen as a top parent
    // apply some Theme
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const NoteList(),
    );
  }
}