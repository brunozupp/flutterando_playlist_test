import 'dart:math' as math;

class Person {
  
  final int id;
  final String name;
  final int age;
  final double height;
  final double weight;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });

  bool get isOlder => age >= 18;

  double get imc {
    var result = weight / math.pow(height, 2);
    result = result * 100;
    return result.roundToDouble() / 100;
  } 
}
