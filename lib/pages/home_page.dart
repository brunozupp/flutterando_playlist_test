import 'package:flutter/material.dart';
import 'package:flutterando_playlist_test/blocs/task_bloc.dart';
import 'package:flutterando_playlist_test/providers/bloc_provider.dart';
import 'package:flutterando_playlist_test/states/task_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final bloc = context.dependOnInheritedWidgetOfExactType<BlocProvider>()!.bloc;
    final bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task list"),
        actions: [
          StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {

              final isEnabled = bloc.state is TaskListState && (bloc.state as TaskListState).data.isNotEmpty;
              
              return IconButton(
                onPressed: isEnabled ? () {
                  bloc.add(TaskEvent.clear);
                } : null, 
                icon: Icon(
                  Icons.refresh_outlined
                ),
              );
              
            }
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            
            if(bloc.state is TaskErrorState) {
              return _ErrorWidget();
            } else if(bloc.state is TaskLoadingState) {
              return LoadingProgress();
            } else {
              return _ListWidget();
            }
            
          }
        ),
      ),
    );
  }
}

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Carregando");
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of(context);
    final textError = (bloc.state as TaskErrorState).error?.toString() ?? "Unknow error";
    
    return Text(
      textError
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of(context);
    final listTask = (bloc.state as TaskListState).data;

    if(listTask.isEmpty) {
      return TextButton(
        onPressed: () {
          bloc.add(TaskEvent.fetch);
        }, 
        child: Text("Fetch data")
      );
    }

    return ListView.builder(
      itemCount: listTask.length,
      itemBuilder: (context, index) {
        final item = listTask[index];

        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.completed ? "Completada" : "Não completada"),
        );
      },
    );
  }
}