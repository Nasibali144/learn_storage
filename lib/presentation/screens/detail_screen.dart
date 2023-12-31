import 'package:flutter/material.dart';
import 'package:learn_storage/core/service_locator.dart';
import 'package:learn_storage/domain/models/todo.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /// state manage
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveTodo() async {
    String title = titleController.value.text.trim();
    String description = descriptionController.value.text.trim();

    if(title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill out all fields")));
      return;
    }
    final id = repository.readTodo().length + 1;
    final todo = Todo(id: id, title: title, description: description);

    final result = await repository.storeTodo(todo);
    if(result && mounted) {
      Navigator.pop(context, "done");
    } else {
      /// error msg
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Some thing error, try again later")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
        actions: [
          IconButton(onPressed: saveTodo, icon: const Icon(Icons.save))
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: "Description",
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
