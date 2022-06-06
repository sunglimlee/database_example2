import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  // 데이터 넘겨받을때 그냥 바로 widget.appBarTitle 을 NoteDetailState 에서 사용하면 된다
  // Don't use parameter for Constructor in StatefulWidget.
  final String appBarTitle;
  const NoteDetail(this.appBarTitle, {Key? key}) : super(key: key);

  @override
  State createState() {
    return NoteDetailState();
  }
}
// [error] 생성자 함수 만드는데 class NoteDetailState() 이렇게 또 해놓으면 어떻하니?
class NoteDetailState extends State<NoteDetail> {

  // for DropdownButton
  static final _priorities = ['High', 'Low'];
  // for TextFormField or TextField input handling
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 뒤로가기 버턴
      // Write some code to control things, when user press back navigation button in device
      onWillPop: () async {
        bool? result= await moveToLastScreen();
        result ??= false;
        return result;

      },
      child : Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },),
      ),
      body: getNoteDetailListView(),
    )
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

  moveToLastScreen() {
    Navigator.pop(context);

  }
}
