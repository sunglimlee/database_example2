import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({Key? key}) : super(key: key);

  @override
  State createState() {
    return _NoteDetailState();
  }
}

class _NoteDetailState extends State<NoteDetail> {
  // for DropdownButton
  static final _priorities = ['High', 'Low'];
  // for TextFormField or TextField input handling
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: getNoteDetailListView(),
    );
  }

  Padding getNoteDetailListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
      child: ListView(
        children: [
          ListTile(
            title: DropdownButton<String>(
              items: _priorities.map((String dropDownStingItem) {
                //[error] check the name 'Drop down menu Item <String> ()'
                return DropdownMenuItem<String>(
                  value: dropDownStingItem,
                  child: Text(dropDownStingItem),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  debugPrint('Dummy for onChange');
                },);
              },
              style: textStyle,
              value: 'High', //[dummy]
            ),
          ),
          // second Element
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              // [error] Invalid constant value. [answer] remove 'const'
              controller: titleController,
              style: textStyle,
              onChanged: (String value) {
                debugPrint('dummy something changed in TextField');
              },
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
          ),
          // Third Element
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              // [error] Invalid constant value. [answer] remove 'const'
              controller: descriptionController,
              style: textStyle,
              onChanged: (String value) {
                debugPrint('dummy something changed in TextField');
              },
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
          ),
          // Forth Element
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: [
                // for taking equal spaces
                Expanded( // There's no more RaisedButton use ElevatedButton instead
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark, //background color
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColorLight, //text color
                        )
                      ),
                      child: const Text('Save', textScaleFactor: 1.5,),
                      onPressed: () {debugPrint('[dummy] save, validation'); },
                    )
                ),
                Container(width: 5.0,), // spacing between buttons
                Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark, //background color
                          textStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight, //text color
                          )
                      ),
                      child: const Text('Delete', textScaleFactor: 1.5,),
                      onPressed: () {debugPrint('[dummy] delete, validation'); },
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
