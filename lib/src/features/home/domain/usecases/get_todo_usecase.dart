import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failures.dart';
import 'package:todo_app/src/core/usecases/usecase.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/domain/repositories/todo_repository.dart';

class GetTodoUseCase implements UseCase<Todo, String> {
  GetTodoUseCase(this.repository);
  final TodoRepository repository;
  @override
  Future<Either<Failure, Todo>> call(String id) {
    return repository.getTodo(id);
  }
}
