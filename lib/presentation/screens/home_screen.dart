import 'package:flutter/material.dart';
import 'package:learn_storage/core/service_locator.dart';
import 'package:learn_storage/domain/models/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// state manage
  List<Todo> todos = [];
  void getAllTodos() {
    todos = repository.readTodo();
    setState(() {});
  }


  /// ui => build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
