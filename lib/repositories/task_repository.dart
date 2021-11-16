import 'dart:convert';

import 'package:http/http.dart';

import 'package:flutterando_playlist_test/models/task.dart';

class TaskRepository {

  final Client client;

  TaskRepository({
    required this.client,
  });

  Future<List<Task>> getTasks() async {
    final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/"));

    if(response.statusCode == 200) {

      final json = jsonDecode(response.body) as List;

      return json.map((e) => Task.fromMap(e)).toList();

    } else {
      throw Exception("Error na internet");
    }
  }
}
