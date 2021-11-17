import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterando_playlist_test/blocs/task_bloc.dart';
import 'package:flutterando_playlist_test/models/task.dart';
import 'package:flutterando_playlist_test/pages/home_page.dart';
import 'package:flutterando_playlist_test/providers/bloc_provider.dart';
import 'package:flutterando_playlist_test/repositories/task_repository.dart';
import 'package:flutterando_playlist_test/states/task_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {

  final repository = MockTaskRepository();
  final bloc = TaskBloc(repository);

  testWidgets("Deve mostrar todos os estados na tela", (WidgetTester tester) async {

    when(repository.getTasks())
        .thenAnswer((realInvocation) async => <Task>[
          Task(id: 1, completed: true, userId: 1, title: "Titulo 1"),
          Task(id: 2, completed: true, userId: 1, title: "Titulo 2"),
          Task(id: 3, completed: true, userId: 1, title: "Titulo 3"),
          Task(id: 4, completed: false, userId: 2, title: "Titulo 4"),
          Task(id: 5, completed: false, userId: 2, title: "Titulo 5"),
        ]);
    
    await tester.pumpWidget(
      BlocProvider(
        bloc: bloc,
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    final textButton = find.byType(TextButton);
    expect(textButton, findsOneWidget);

    final loading = find.byType(LoadingProgress);
    expect(loading, findsNothing);

    final listTasks = find.byType(ListView);
    expect(listTasks, findsNothing);

    status("Antes de clicar no botão", bloc);

    await tester.tap(textButton);

    status("Após de clicar no botão", bloc);

    await tester.pumpAndSettle(); // É como se fosse o setState que força a ir para o próximo frame    

    await tester.runAsync(() => bloc.stream.first);

    // status("Após o primeiro runAsync", bloc);
    // await tester.pumpAndSettle();
    // expect(loading, findsOneWidget);

    // await tester.runAsync(() async => await bloc.stream.first);
    await tester.pumpAndSettle();
    expect(listTasks, findsOneWidget);
  });

  
}

void status(String title, TaskBloc bloc) {
  print("\n$title ------------------------");
  print("bloc.state is TaskLoadingState = ${bloc.state is TaskLoadingState}");
  print("bloc.state is TaskErrorState = ${bloc.state is TaskErrorState}");
  print("bloc.state is TaskListState = ${bloc.state is TaskListState}");
}