class CalculatorModel {
  List<String> values;
  bool newNumber;

  CalculatorModel({this.newNumber = false}) : values = [];

  void push(String value) {
    values.add(value);
  }

  void clear() {
    values = [];
  }

  bool isEmpty() {
    return values.isEmpty;
  }

  String peek() {
    try {
      return values.last;
    } catch (e) {
      return "";
    }
  }

  String peekBefore() {
    return values[values.length - 2];
  }
}
