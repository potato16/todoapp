import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failures.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodolist();
  Future<Either<Failure, bool>> updateTodo(Todo item);
  Future<Either<Failure, bool>> addTodo(Todo item);
  Future<Either<Failure, bool>> deleteTodo(String id);
  Future<Either<Failure, Todo>> getTodo(String id);
}
