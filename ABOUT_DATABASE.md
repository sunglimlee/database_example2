This video talks about...

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
  * 안드로이드 Back Button을 구현하고 싶으면 WillPopScope widget 사용
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
        //await 가 없으면 downloadAFile은 Future<String>을 리턴한다.
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

 