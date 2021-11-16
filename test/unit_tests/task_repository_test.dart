import 'package:flutterando_playlist_test/repositories/task_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {

  final client = MockClient();

  final repository = TaskRepository(client: client);

  test("Deve pegar uma lista de tasks", () async {

    when(client.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/")))
        .thenAnswer((invocation) async => http.Response(jsonReturn, 200));

    final list = await repository.getTasks();

    expect(list.isNotEmpty, equals(true));
    expect(list.first.title, equals("Um novo rumo"));
  });

  test("Retorna uma exception se não for statusCode 200", () async {

    when(client.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/")))
        .thenAnswer((invocation) async => http.Response(jsonReturn, 404));

    expect(() async => await repository.getTasks(), throwsException);
  });
}

const jsonReturn  = '''[
  {
    "userId": 1,
    "id": 15,
    "title": "Um novo rumo",
    "completed": true
  },
  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  },
  {
    "userId": 1,
    "id": 3,
    "title": "fugiat veniam minus",
    "completed": false
  },
  {
    "userId": 1,
    "id": 4,
    "title": "et porro tempora",
    "completed": true
  },
  {
    "userId": 1,
    "id": 5,
    "title": "laboriosam mollitia et enim quasi adipisci quia provident illum",
    "completed": false
  }]''';