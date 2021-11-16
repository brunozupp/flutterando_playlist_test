import 'package:flutterando_playlist_test/models/person.dart';
import 'package:test/test.dart';

void main() {

  final person = Person(
    id: 1,
    name: "Bruno",
    age: 22,
    height: 1.77,
    weight: 64.4
  );

  test("Imc DEVE dar o valor de 20.56", () {
    expect(person.imc, 20.56);
  });

  group("Group about Person.age   |   ", () {

    test("Person.age DEVE dar isOlder = true", () {
      expect(person.isOlder, true);
    });

    test("Person.age DEVE dar isOlder = false", () {
      final person = Person(
        id: 2,
        name: "Bruno",
        age: 12,
        height: 1.77,
        weight: 64.4
      );

      expect(person.isOlder, false);
    });
  });
}