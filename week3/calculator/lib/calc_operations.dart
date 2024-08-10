class Operations {
  final double a, b;

  Operations({required this.a, required this.b});

  //Addition
  double add() {
    return a + b;
  }

  //Substraction
  double substract() {
    return a - b;
  }

  //Multiplication
  double multiply() {
    return a * b;
  }

  //Division
  double divide() {
    return a / b;
  }

  //Percentage
  double percentage() {
    return (a * b) / 100;
  }
}
