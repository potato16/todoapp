import 'package:todo_app/src/features/home/data/models/todo_model.dart';

abstract class TodoMockDataSource {
  Future<List<Todo>> getTodolist();

  Future<Todo> getTodo(String id);
  Future<bool> updateTodo(Todo item);
  Future<bool> addTodo(Todo item);
  Future<bool> deleteTodo(String id);
}

class TodoMockDataSourceImpl implements TodoMockDataSource {
  List<Todo> data = [
    Todo(id: '1', title: 'Workout'),
    Todo(id: '2', title: 'Medical checkup'),
    Todo(id: '3', title: 'Go to Grocery'),
    Todo(id: '4', title: 'Buy 3 pen', isDone: true),
  ];
  @override
  Future<bool> deleteTodo(String id) async {
    final item = data.firstWhere(
      (element) => element.id == id,
    );
    return data.remove(item);
  }

  @override
  Future<Todo> getTodo(String id) async {
    return data.firstWhere(
      (element) => element.id == id,
    );
  }

  @override
  Future<List<Todo>> getTodolist() async {
    return List.from(data);
  }

  @override
  Future<bool> updateTodo(Todo item) async {
    final index = data.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      return false;
    }
    data[index] = item;
    return true;
  }

  @override
  Future<bool> addTodo(Todo item) async {
    final index = data.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      data.add(item);
      return true;
    }
    return false;
  }
}
