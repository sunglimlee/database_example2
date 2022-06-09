This video talks about...

202206091543
* ********* database location ***************************************************
* I find for my own Flutter apps that the relevant path is /data/usr/0/…/app_flutter for the example you gave, this would be /data/usr/0/com.example.localsStorageExample/app_flutter
* View/Tool Windows/App Inspection/Database 에서 데이터베이스를 다룰 수 있고 export 도 할 수 있다.
* https://developer.android.com/studio/inspect/database //데이터베이스에 관련된 링크 참조.
* ************************************************************************

202206061919
* **************** Error Handling *******************************************
* 
* ***************************************************************************
* **************** Database Helper Class ************************************
* database_helper.dart
* Database Helper Class (import 여러가지 파일들)
* Create Singletons
* // named constructor - 다른것보다 훨씬 더 실용적이네..
    // 말그대로 constructor 이나깐 오브젝트를 만들어 내는구나. 그래서 DatabaseHelper() 오브젝트를 만드는구나.
    //https://medium.com/nerd-for-tech/named-constructor-vs-factory-constructor-in-dart-ba28250b2747
    DatabaseHelper._createInstance();
* // factory constructor is STATIC
* // factory constructor should use RETURN statement
* Event Handler 가 필요할 땐 GestureDetector() 를 사용
* Write code for (insert, fetch, update, delete)
* ***************************************************************************
* swipe to delete : https://www.technicalfeeder.com/2021/12/flutter-swipe-list-item-to-delete/
* **************** List 객체 생성하는 방법 잘 봐라.. ****************************
* Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = [];
    for (int i = 0; i < count; i++) {
    noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
    }
* ****************************************************************************




202006061830
* ************ Note Model Class *********************************************
*   // 완전 코틀린.. (late 쓴거나 String? 쓴거나 Kotlin 과 완전 똑같네
    late final String? _description;
    model class 를 만들었다. 여기내용을 잘 보면 많은게 보인다.

202006061810
* ************ SQFLite Plugin deals with MAP Object *************************
* Map Object 만 취급
* 따라서 1. Dependencies in pubspec.yaml (sqfLite : any, path_provider: any, intl: ^0.15.7)
*          path_provider 는 Finds commonly used locations on the file system
*          intl 은 Internationalization package, data/number formatting and parsing
*       2. Model Class (to represent Note object)
*       3. Database Helper Class (to perform CRUD operation)
*       4. Connect Database to UI
***************************************************************************** 



202206061715
* ************ Asynchronous Tutorial using Future API with then *************
  import 'dart:async';
  main() {
  //3. 실행함수를 돌려준다.
  print('Main program: Starts');
  printFileContent();
  print('Main program: Ended');
  }
  //2. Thread 함수를 실행할 함수에다가 then 으로 감싸서 람다함수로 resultString 을 받아서 print 실행한다.
  printFileContent() {
  Future<String> fileContent= downloadAFile();
  fileContent.then((resultString) {
  print('The content of the file is -> $resultString');
  });
  }
  //1. Thread 작업할 함수만들고 리턴값을 Future 로 감싸준다.
  //To download a file(Dummy a long running operation)
  Future<String> downloadAFile() {
  Future<String> result = Future.delayed(Duration(second: 6), () {
  return 'My secret file content';
  }
  * ********************************************************************

202206061512
- How Screens are stacked in Flutter?
- Navigate to a screen
- Navigate back to the last screen

- how to navigate to a screen
  * Route means Screen in Flutter
  * push and pop by Navigator Widget (check the FAB button for example)
  * Pass your data when you Navigate screen
    https://stackoverflow.com/questions/50287995/passing-data-to-statefulwidget-and-accessing-it-in-its-state-in-flutter
  * push & pop manually (내가 정하고 싶을 때)
    appBar 에 leading 아이템을 넣으면 된다. 
  * 안드로이드 Back Button 을 구현하고 싶으면 WillPopScope widget 사용
  * ************ Asynchronous Tutorial using Future API with async, await *************
    import 'dart:async';
    main() {
    //3. 실행함수를 돌려준다.
       print('Main program: Starts');
       printFileContent();
       print('Main program: Ended');
    }
    //2. Thread 함수를 실행할 함수에다가 async 와 await 를 넣어준다.
    printFileContent() async {
        //await 가 없으면 downloadAFile 은 Future<String>을 리턴한다.
        String fileContent= await downloadAFile();
        print('The content of the file is -> $fileContent');
    }
    //1. Thread 작업할 함수만들고 리턴값을 Future 로 감싸준다.
    //To download a file(Dummy a long running operation)
    Future<String> downloadAFile() {
        Future<String> result = Future.delayed(Duration(second: 6), () {
            return 'My secret file content';
    }
  * ****************** 데이터베이스 전반적인 구조 ***************************
* 0. Building App UI
* 1. Navigating between screens in Flutter
* 2. Asynchronous Programming (Future, Async, Await, Then)
* 3. Creating Database Model Class
* 4. Singletons, Creating Database Helper Class
* 5. Plugins (SQFLite, Path_Provider, Intl)
* 6. Performing CRUD Operation
* 7. Conclusion
************************************************************************** 