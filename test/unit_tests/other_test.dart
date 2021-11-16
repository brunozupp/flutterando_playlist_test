@Timeout(Duration(seconds: 60))
//@Skip("Feature ainda não completa") // Não vai executar a suit
//@Tags(['TAG_A','TAG_B']) // Tagear toda a suit
import 'package:test/test.dart';

void main() {
  
  test("Matchers in separeted expect", () {

    final name = "James";

    expect(name, equals("James"));
    expect(name, isA<String>());
    expect(name, isNotNull);
    expect(name, contains("es"));
  });

  test("Matchers in just one expect", () {

    final name = "James";

    expect(name,
      allOf([
        equals("James"),
        isA<String>(),
        isNotNull,
        contains("es")
      ])
    );
  });

  // Quando eu quero que lança um erro eu preciso fazer uma função executando o bloco de código em questão
  test("Should Throw error", () {
    expect(() => int.parse('x'), throwsA(isA<Exception>()));
  });

  test("Should Throw error - matcher", () {
    expect(() => int.parse('x'), throwsException);
  });

  test("Timeout test", () {
    expect(() => int.parse('x'), throwsException);
  }, timeout: Timeout(Duration(seconds: 10)));
  // Posso especificar um timeout maior. Pode colocar no expect direto, num grupo, ou diretamente no suit

  test("Teste que não vai executar", () {
    expect(() => int.parse('x'), equals(true)); // era para gerar um erro, mas como não vai ser executado
  }, skip: "Teste não vai ser executado pois está com o skip");

  test("Should Throw error - TAG A", () {
    expect(() => int.parse('x'), throwsA(isA<Exception>()));
  }, tags: 'TAG_A');

  test("Should Throw error - matcher - TAG A", () {
    expect(() => int.parse('x'), throwsException);
  }, tags: 'TAG_A');

  test("Timeout test - TAG B", () {
    expect(() => int.parse('x'), throwsException);
  },
  tags: 'TAG_B', 
  timeout: Timeout(Duration(seconds: 10)));
}