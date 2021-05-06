import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/exceptions.dart';
import 'package:todo_app/src/core/error/failures.dart';
import 'package:todo_app/src/features/home/data/datasources/todo_mock_data_source.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl({
    required this.mockDataSource,
  });
  final TodoMockDataSource mockDataSource;

  @override
  Future<Either<Failure, List<Todo>>> getTodolist() async {
    try {
      final todos = await mockDataSource.getTodolist();
      return Right(todos);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addTodo(Todo item) async {
    try {
      final result = await mockDataSource.addTodo(item);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(String id) async {
    try {
      final result = await mockDataSource.deleteTodo(id);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(String id) async {
    try {
      final result = await mockDataSource.getTodo(id);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateTodo(Todo item) async {
    try {
      final result = await mockDataSource.updateTodo(item);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
