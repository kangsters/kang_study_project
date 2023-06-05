class Word {
  final String term;
  final String definition;
  Word({
    required this.term,
    required this.definition,
  });
}

typedef WordsInput = List<Map<String, String>>;

class Dictionary {
  Map<String, Word> words = {};

  bool exists(String term) {
    return words.containsKey(term);
  }

  Word? get(String term) {
    return words[term];
  }

  void add(String term, String definition) {
    if (!exists(term)) {
      words[term] = Word(
        term: term,
        definition: definition,
      );
    }
  }

  void showAll() {
    print("----");
    words.forEach((key, value) {
      print("${value.term}: ${value.definition}\n");
    });
    print("----");
  }

  int count() {
    return words.length;
  }

  void update(String term, String definition) {
    if (exists(term)) {
      words[term] = Word(
        term: term,
        definition: definition,
      );
    }
  }

  void delete(String term) {
    if (exists(term)) {
      words.remove(term);
    }
  }

  void upsert(String term, String definition) {
    if (exists(term)) {
      update(term, definition);
    } else {
      add(term, definition);
    }
  }

  void bulkAdd(WordsInput words) {
    for (var word in words) {
      if (word.containsKey('term') && word.containsKey('definition')) {
        add(word["term"] ?? "", word["definition"] ?? "");
      }
    }
  }

  void bulkDelete(List<String> keys) {
    for (var key in keys) {
      delete(key);
    }
  }
}

void main() {
  var dictionary = Dictionary();

  dictionary.add("김치", "한국 음식");
  dictionary.showAll();

  // Count
  print(dictionary.count());

  // Update
  dictionary.update("김치", "밋있는 한국 음식!!!");
  print(dictionary.get("김치"));

  // Delete
  dictionary.delete("김치");
  print(dictionary.count());

  // Upsert
  dictionary.upsert("김치", "밋있는 한국 음식!!!");
  print(dictionary.get("김치"));
  dictionary.upsert("김치", "진짜 밋있는 한국 음식!!!");
  print(dictionary.get("김치"));

  // Exists
  print(dictionary.exists("김치"));

  // Bulk Add
  dictionary.bulkAdd([
    {"term": "A", "definition": "B"},
    {"term": "X", "definition": "Y"}
  ]);
  dictionary.showAll();

  // Bulk Delete
  dictionary.bulkDelete(["A", "X"]);
  dictionary.showAll();
}
