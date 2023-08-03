import 'package:flutter/material.dart';
import 'package:learn_storage/core/service_locator.dart';
import 'package:learn_storage/domain/models/todo.dart';

class EditScreen extends StatefulWidget {
  final Todo todo;
  const EditScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  /// state manage
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getOldTodo();
  }

  void getOldTodo() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    setState(() {});
  }

  void saveTodo() async {
    String title = titleController.value.text.trim();
    String description = descriptionController.value.text.trim();

    if(title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill out all fields")));
      return;
    }
    final todo = Todo(id: widget.todo.id, title: title, description: description, imageUrl: widget.todo.imageUrl);

    final result = await repository.editTodo(todo);
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
        title: const Text("Edit Todo"),
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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
