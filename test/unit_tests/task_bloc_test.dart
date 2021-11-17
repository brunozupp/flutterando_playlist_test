
import 'package:flutterando_playlist_test/blocs/task_bloc.dart';
import 'package:flutterando_playlist_test/models/task.dart';
import 'package:flutterando_playlist_test/repositories/task_repository.dart';
import 'package:flutterando_playlist_test/states/task_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'task_bloc_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {

  final repository = MockTaskRepository();
  final bloc = TaskBloc(repository);

  test("deve retornar uma lista de tasks", () async {

    when(repository.getTasks())
        .thenAnswer((realInvocation) async => <Task>[
          Task(id: 1, completed: true, userId: 1, title: "Titulo 1"),
          Task(id: 2, completed: true, userId: 1, title: "Titulo 2"),
          Task(id: 3, completed: true, userId: 1, title: "Titulo 3"),
          Task(id: 4, completed: false, userId: 2, title: "Titulo 4"),
          Task(id: 5, completed: false, userId: 2, title: "Titulo 5"),
        ]);

    // Outro meio de testar uma stream é colocar antes do evento adicionado o expect
    //expect(bloc.stream, emitsInOrder([isA<TaskLoadingState>(), isA<TaskListState>()]));

    bloc.add(TaskEvent.fetch);

    // A diferença entre o expectLater e o expect é que esse retorna um futuro. Esse é o segredo para testar uma stream
    await expectLater(bloc.stream, emitsInOrder([isA<TaskLoadingState>(), isA<TaskListState>()]));
  });
}