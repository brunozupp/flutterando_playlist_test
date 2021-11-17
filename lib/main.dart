import 'package:flutter/material.dart';
import 'package:flutterando_playlist_test/blocs/task_bloc.dart';
import 'package:flutterando_playlist_test/pages/home_page.dart';
import 'package:flutterando_playlist_test/providers/bloc_provider.dart';
import 'package:flutterando_playlist_test/repositories/task_repository.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TaskBloc(
        TaskRepository(
          client: Client()
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}