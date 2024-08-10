class CalculatorModel {
  List<String> values;
  bool newNumber;

  CalculatorModel({this.newNumber = false}) : values = [];

  //Pushing values to the list
  void push(String value) {
    values.add(value);
  }

  //Clearing the list.
  void clear() {
    values = [];
  }

  //List emptiness checker.
  bool isEmpty() {
    return values.isEmpty;
  }

  //Returns the last value of the list.
  String peek() {
    try {
      return values.last;
    } catch (e) {
      return "";
    }
  }

  //Returns the value before the last of the list.
  String peekBefore() {
    return values[values.length - 2];
  }
}
