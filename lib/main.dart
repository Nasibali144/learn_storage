import 'package:flutter/cupertino.dart';
import 'package:learn_storage/app.dart';
import 'package:learn_storage/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const TodoApp());
}