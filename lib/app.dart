import 'package:flutter/material.dart';
import 'package:learn_storage/core/service_locator.dart';
import 'package:learn_storage/presentation/screens/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: mode,
      child: const Home(),
      builder: (_, mode, child) {
        return MaterialApp(
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: child,
        );
      }
    );
  }
}
