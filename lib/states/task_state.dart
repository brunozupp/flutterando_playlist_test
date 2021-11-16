import 'package:flutterando_playlist_test/models/task.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TaskState { 
  const TaskState();
}

@immutable
class TaskListState extends TaskState {
  final List<Task> data;

  const TaskListState(this.data);
}

@immutable
class TaskLoadingState extends TaskState {
  const TaskLoadingState();
}

@immutable
class TaskErrorState extends TaskState {
  final dynamic error;

  const TaskErrorState([this.error]);
}