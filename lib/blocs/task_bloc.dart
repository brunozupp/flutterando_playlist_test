import 'package:bloc/bloc.dart';
import 'package:flutterando_playlist_test/repositories/task_repository.dart';
import 'package:flutterando_playlist_test/states/task_state.dart';

enum TaskEvent {
  clear, fetch
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskListState([])) {

    on<TaskEvent>((event, emit) async {

      if(event == TaskEvent.fetch) {

        emit(TaskLoadingState());
        
        try {
          final list = await repository.getTasks();
          emit(TaskListState(list));
        } catch (e) {
          emit(TaskErrorState(e));
        }

      } else {
        emit(TaskListState([]));
      }
    });
  }
}