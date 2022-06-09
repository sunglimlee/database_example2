class Note {
  // 완전 코틀린.. (late 쓴거나 String? 쓴거나 Kotlin 과 완전 똑같네
  //[error] [ERROR:flutter/runtime/dart_vm_initializer.cc(39)] Unhandled Exception: LateInitializationError: Field '_id@28339384' has not been initialized.
  // 이부분을 처음에는 late int _id 로 했는데 그렇게 하면 null 이 되면 안된다는 뜻이잖아.. 왜냐하면 null 도 값이거든.
  // 그래서 초기화 자체가 안되어 있는데 null 인지 비교하는 것 자체가 안되는 거지.. 잘했어..
  int? _id; // 기억하자 null 도 값이다. remember null is also value in Dart.
  late String _title;
  late String _description;
  late String date;
  late int _priority;

  // Constructors (Named Constructor too)
  Note(this._title, this.date, this._priority, this._description);

  Note.withId(
      this._id, this._title, this._description, this.date, this._priority);

  int get priority => _priority;

  int? get id => _id;

  String get description => _description;

  String get title => _title;

  // switch case statement 문장 사용
  set priority(int value) {
    switch (value) {
      case 1:
        {
          _priority = value;
          break;
        }
      case 2:
        {
          _priority = value;
          break;
        }
    }
  }

  set description(String value) {
    if (value.length <= 255) {
      _description = value;
    }
  }

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

// *************** Map object 관련된 부분 ***********************
  // convert a Note object into Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{}; // Map<String, dynamic> 과 같은 것
    //id 경우에는 new 인지 edit 인지 확인해야 한다.
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = date;
    map['property'] = _priority;
    return map;
  }

  // Extract a Note object from a Map object
  // named constructor 생성자 함수를 이용해서 map 값을 note 객체로 만들어주는거네.. 말된다.
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    date = map['date'];
    _priority = map['property'];
  }
  // ***********************************************************
}
