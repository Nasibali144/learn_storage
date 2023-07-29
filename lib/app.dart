import 'package:flutter/material.dart';
import 'package:learn_storage/presentation/screens/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
