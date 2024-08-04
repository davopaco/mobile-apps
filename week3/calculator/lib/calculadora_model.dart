class CalculadoraModel {
  List<double> values;
  bool newNumber;

  CalculadoraModel({this.newNumber = false}) : values = [];

  void push(value) {
    values.add(value);
  }

  void clear() {
    values = [];
  }

  bool isEmpty() {
    return values.isEmpty;
  }

  double peek() {
    return values.last;
  }

  double peekBefore() {
    return values[values.length - 2];
  }
}
