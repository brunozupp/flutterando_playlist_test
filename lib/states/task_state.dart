import 'package:flutterando_playlist_test/models/task.dart';
import 'package:meta/meta.dart';

abstract class TaskState { 
}

class TaskListState extends TaskState {
  final List<Task> data;

  TaskListState(this.data);
}

class TaskLoadingState extends TaskState { }

@immutable
class TaskErrorState extends TaskState {
  final dynamic error;

  TaskErrorState([this.error]);
}