import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/usecases/usecase.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/domain/usecases/get_todolist_use_case.dart';

import 'home_provider.dart';

final todoListProvider =
    StateNotifierProvider<TodoListStateNotifier, List<Todo>>((ref) {
  final usecase = ref.watch(getTodolistUscaseProvider);
  return TodoListStateNotifier([], usecase: usecase);
});

class TodoListStateNotifier extends StateNotifier<List<Todo>> {
  TodoListStateNotifier(List<Todo> state, {required this.usecase})
      : super(state);
  final GetTodoListUsecase usecase;
  Future<void> fetch() async {
    final result = await usecase.call(NoParams());
    state = result.fold((l) => [], (r) => r);
  }
}
