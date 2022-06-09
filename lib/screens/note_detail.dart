import 'package:database_example/models/note.dart';
import 'package:database_example/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  // 데이터 넘겨받을때 그냥 바로 widget.appBarTitle 을 NoteDetailState 에서 사용하면 된다
  // Don't use parameter for Constructor in StatefulWidget.
  final String appBarTitle;
  final Note note;
  const NoteDetail(this.note, this.appBarTitle, {Key? key}) : super(key: key);

  @override
  State createState() {
    return NoteDetailState();
  }
}
// [error] 생성자 함수 만드는데 class NoteDetailState() 이렇게 또 해놓으면 어떻하니?
class NoteDetailState extends State<NoteDetail> {

  // 똑같이 DatabaseHelper 를 불러서 작업한다.
  DatabaseHelper helper = DatabaseHelper();

  // for DropdownButton
  static final _priorities = ['High', 'Low'];
  // for TextFormField or TextField input handling
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 이렇게 하는게 가능하나???
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;

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
                  debugPrint('User selected $value');
                  updatePriorityAsInt(value!); // 느낌표 넣어주어야 하네.. 이게 null 이면 실행이 안되네.
                },);
              },
              style: textStyle,
              value: getPriorityAsString(widget.note.priority),
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
                debugPrint('something changed in TextField');
                // 실제로 데이터가 바뀌니깐 밖에서 받은 note 객체의 값을 바꾸어주는구나.
                updateTitle();
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
                debugPrint('something changed in TextField');
                updateDescription();
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
                      onPressed: () {
                        debugPrint('save, validation');
                        _save();
                        },
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
                      onPressed: () {
                        debugPrint('delete, validation');
                        _delete();
                        },
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
    // *********** 여기서 데이터 값을 전달해 준다. ****************************************
    // 현재는 그냥 true 를 넘기는데 향후에는 마지막의 값을 넘기는게 좋겠지..
    Navigator.pop(context, true);

  }
  // priority 의 int 값을 String 값으로 변환한다.
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High' :
        widget.note.priority = 1;
        break;
      case 'Low' :
        widget.note.priority = 2;
        break;
    }
  }

  // priority 의 String 값을 int 값으로 변환한다.
  String getPriorityAsString(int value) {
    String priority; // 모든건 not-nullable 로 시작한다.
    switch (value) {
      case 1 :
        priority = _priorities[0]; // 'High'
        break;
      case 2 :
        priority = _priorities[1]; // 'Low'
        break;
      default :
        priority = _priorities[1]; // 'Low'
        break;
    }
    // [error] The non-nullable local variable 'priority' must be assigned before it can be used.
    //  default 문도 넣어주자.
    return priority;
  }
  // Update title of Note object
  void updateTitle() {
    widget.note.title= titleController.text; // controller 가 값을 핸들링한다고 했지!
  }
  void updateDescription() {
    widget.note.description = descriptionController.text;
  }

  void _delete() async {
    moveToLastScreen();
    // case 1 : If user s trying to delete the new Note i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (widget.note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }
    // case 2 ; User is trying to delete the old note that already has a valid ID
    int result = await helper.deleteNote(widget.note.id!);
    switch (result) {
      case 0: {
        _showAlertDialog('Status', 'Error occurred while deleting Note');
        break;
      }
      default : {
        _showAlertDialog('Status', 'Note deleted successfully');
        break;
      }
    }
  }

  // for save button saving into database 이제 데이터베이스에 저장한다. 당연히 async 가 되어야 함.
  void _save() async {
    debugPrint("파일저장 start");
    // 여기서 미리 전 화면으로 가도록 하네..
    moveToLastScreen();
    // Date, 날짜에 관련된 format 포맷
    widget.note.date = DateFormat.yMMM().format(DateTime.now());
    int result;
    debugPrint("파일저장 after ${widget.note.id}");
    // int? _id; 이렇게 해야지 밑에 문제가 안생긴다. late int _id; 라고 하면 값이 분명히 존재해야 하는데
    // null 도 값인데 비교자체가 안되잖아... 그래서 exception 이 생기는 거지..
    if (widget.note.id != null) { //case 1 : Update operation
      debugPrint("파일저장 null 아님");
      result = await helper.updateNote(widget.note);
    } else { // case 2 : Add operation
      debugPrint("파일저장 null 이다");
      result = await helper.insertNote(widget.note);
    }
    if (result != 0) { // success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {   //failure
      _showAlertDialog('status', 'Problem on Saving Note');

    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

}
