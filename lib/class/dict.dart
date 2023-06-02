class Dictionary {
  final Map<String, dynamic> _wordList = {
    "단어": "단어의 정의",
  };

  final List<Map> _dictionaryList = [
    {"term": "김치", "definition": "대박이네"},
  ];

  void add(String key, dynamic value) {
    _wordList.addAll({key: value});
    print(_wordList);
  }

  String get(String word) {
    if (_wordList.containsKey(word)) {
      int i = _wordList.keys.toList().indexOf(word);
      return _wordList[i].value.toString();
    }
    return "사전에 포함되지 않은 단어입니다.";
  }

  void delete(String word) {
    try {
      _wordList.remove(word);
    } catch (e) {
      throw Exception("사전에 포함되지 않은 단어입니다.");
    }
  }

  void update(String key, dynamic value) {
    try {
      _wordList.update(key, (oldVal) => value);
    } catch (e) {
      throw Exception("사전에 포함되지 않은 단어입니다.");
    }
  }

  List<String> showAll() {
    List<String> a = [];

    for (int i = 0; i < _wordList.length; i++) {
      String _key = _wordList.keys.toList()[i];
      String _value = _wordList.values.toList()[i];
      a.add("$_key의 뜻은 $_value 입니다.");
    }

    return a;
  }

  int count() {
    return _wordList.length;
  }

  void upsert(String key, dynamic value) {
    if (_wordList.containsKey(key)) {
      _wordList.update(key, (oldVal) => value);
      return;
    }
    add(key, value);
  }

  bool exsist(String key) {
    if (_wordList.containsKey(key)) {
      return true;
    }
    return false;
  }

  void bulkadd(Map<String, dynamic> words) {
    _wordList.addAll(words);
  }
}
