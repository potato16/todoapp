import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failures.dart';
import 'package:todo_app/src/core/usecases/usecase.dart';
import 'package:todo_app/src/features/home/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase implements UseCase<bool, String> {
  DeleteTodoUsecase(this.repository);
  final TodoRepository repository;
  @override
  Future<Either<Failure, bool>> call(String id) {
    return repository.deleteTodo(id);
  }
}
