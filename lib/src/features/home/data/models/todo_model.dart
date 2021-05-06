import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  const Todo(
      {required this.id,
      required this.title,
      this.description,
      this.isDone = false});
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  final String id;
  final String title;
  final String? description;
  final bool isDone;

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [id, title, description, isDone];
  Todo copyWith({String? newTitle, String? newDescription, bool? newIsDone}) {
    return Todo(
        id: id,
        title: newTitle ?? title,
        description: newDescription ?? description,
        isDone: newIsDone ?? isDone);
  }
}
