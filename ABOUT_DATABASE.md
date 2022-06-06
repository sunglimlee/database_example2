This video talks about...

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
  * ********************************************************************

 