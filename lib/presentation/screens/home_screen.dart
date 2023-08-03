import 'package:flutter/material.dart';
import 'package:learn_storage/core/service_locator.dart';
import 'package:learn_storage/domain/models/todo.dart';
import 'package:learn_storage/presentation/screens/detail_screen.dart';
import 'package:learn_storage/presentation/screens/edit_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// state manage
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  void getAllTodos() {
    todos = repository.readTodo();
    setState(() {});
  }

  void goDetailPage() async {
    final msg = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const Detail()));
    if (msg == "done") {
      getAllTodos();
    }
  }

  void deleteTodo(Todo todo) async {
    final result = await repository.deleteTodo(todo);
    if(result && mounted) {
      getAllTodos();
    } else {
      /// error msg
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Some thing error, try again later")));
    }
  }

  void editTodo(Todo todo) async {
    final msg = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => EditScreen(todo: todo)));
    if (msg == "done") {
      getAllTodos();
    }
  }

  /// ui => build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todos")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: todos.length,
        itemBuilder: (_, index) {
          final todo = todos[index];
          return Dismissible(
            key: ValueKey<String>(todo.title),
            background: const Center(child: Icon(Icons.delete)),
            onDismissed: (direction) {
              deleteTodo(todo);
            },
            child: Card(
              child: ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: IconButton(
                  onPressed: () => editTodo(todo),
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goDetailPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
