class Operations {
  final double a, b;

  Operations({required this.a, required this.b});

  double add() {
    return a + b;
  }

  double substract() {
    return a - b;
  }

  double multiply() {
    return a * b;
  }

  double divide() {
    return a / b;
  }

  double percentage() {
    return (a * b) / 100;
  }
}
