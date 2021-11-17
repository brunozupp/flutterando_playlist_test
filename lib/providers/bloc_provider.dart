import 'package:flutter/material.dart';
import 'package:flutterando_playlist_test/blocs/task_bloc.dart';

class BlocProvider extends InheritedWidget {

  final TaskBloc bloc;

  BlocProvider({
    required this.bloc,
    required Widget child
  }) : super(child: child);

  static TaskBloc of(BuildContext context) {
    final BlocProvider? result = context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    assert(result != null, 'No BlocProvider found in context');
    return result!.bloc;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return bloc != (oldWidget as BlocProvider).bloc;
  }
}