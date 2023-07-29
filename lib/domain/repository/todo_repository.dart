import 'dart:convert';

import 'package:learn_storage/data/local_data_source.dart';
import 'package:learn_storage/domain/models/todo.dart';

abstract class TodoRepository {
  Future<bool> storeTodo(Todo todo);
  List<Todo> readTodo();
  Future<bool> deleteTodo(Todo todo);
  Future<bool> clearCache();
}

class TodoRepositoryImpl implements TodoRepository {
  final LocalDataSource dataSource;
  const TodoRepositoryImpl({required this.dataSource});

  @override
  Future<bool> clearCache() async {
    return dataSource.remove(StorageKey.todos);
  }

  @override
  Future<bool> deleteTodo(Todo todo) {
    /// Object => json => String
    final list = readTodo();
    list.remove(todo);
    final json = list.map((todo) => todo.toJson());
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.todos, data);
  }

  @override
  List<Todo> readTodo() {
    /// String => json => Object
    String data = dataSource.read(StorageKey.todos) ?? "[]";
    final json = jsonDecode(data) as List;
    return json.map((item) => Todo.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<bool> storeTodo(Todo todo) {
    /// Object => json => String
    final list = readTodo();
    list.add(todo);
    final json = list.map((todo) => todo.toJson());
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.todos, data);
  }
}