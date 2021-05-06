import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/domain/usecases/add_todo_usecase.dart';
import 'package:todo_app/src/features/home/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/src/features/home/domain/usecases/update_todo_usecase.dart';
import 'package:uuid/uuid.dart';

import 'home_provider.dart';

final todoBusinessProvider = StateNotifierProvider.autoDispose
    .family<TodoBusinessStateNotifier, Todo?, Todo?>((ref, init) {
  final addUsecase = ref.watch(addTodoUsecaseProvider);
  final updateUsecase = ref.watch(updateTodoUsecaseProvider);
  final deleteUsecase = ref.watch(deleteTodoUsecaseProvider);
  return TodoBusinessStateNotifier(
    init,
    addUsecase: addUsecase,
    updateUsecase: updateUsecase,
    deleteUsecase: deleteUsecase,
  );
});

final getTodoProvider =
    FutureProvider.family.autoDispose<Todo?, String>((ref, id) async {
  final result = await ref.watch(getTodoUsecaseProvider).call(id);
  return result.fold((l) => null, (r) => r);
});

class TodoBusinessStateNotifier extends StateNotifier<Todo?> {
  TodoBusinessStateNotifier(
    Todo? state, {
    required this.deleteUsecase,
    required this.updateUsecase,
    required this.addUsecase,
  })   : status = state?.isDone ?? false,
        super(state);
  final UpdateTodoUsecase updateUsecase;
  final AddTodoUsecase addUsecase;
  final DeleteTodoUsecase deleteUsecase;
  bool status;

  Future<void> addTodo(
      {required String title, required String description}) async {
    final String id = Uuid().v1();
    state =
        Todo(id: id, title: title, description: description, isDone: status);
    await addUsecase.call(state!);
  }

  Future<void> deleteTodo() async {
    if (state != null) {
      await deleteUsecase.call(state!.id);
    }
  }

  Future<void> updateTodo(
      {required String title, required String description}) async {
    if (state == null) {
      return;
    }
    state = state!.copyWith(
        newTitle: title, newDescription: description, newIsDone: status);
    await updateUsecase.call(state!);
  }

  void updateStatus(bool? value) {
    status = value ?? false;
    state = state;
  }
}
