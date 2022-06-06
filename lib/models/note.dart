class Note {
  // 완전 코틀린.. (late 쓴거나 String? 쓴거나 Kotlin 과 완전 똑같네
  late final int? _id;
  late final String _title;
  late final String _description;
  late final String date;
  late final int _property;

  // Constructors (Named Constructor too)
  Note(this._title, this.date, this._property, this._description);

  Note.withId(
      this._id, this._title, this._description, this.date, this._property);

  int get property => _property;

  int? get id => _id;

  String get description => _description;

  String get title => _title;

  // switch case statement 문장 사용
  set property(int value) {
    switch (value) {
      case 1:
        {
          _property = value;
          break;
        }
      case 2:
        {
          _property = value;
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
    map['property'] = _property;
    return map;
  }

  // Extract a Note object from a Map object
  // named constructor 생성자 함수를 이용해서 map 값을 note 객체로 만들어주는거네.. 말된다.
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    date = map['date'];
    _property = map['property'];
  }
  // ***********************************************************
}
