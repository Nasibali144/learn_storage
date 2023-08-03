import 'package:flutter/material.dart';
import 'package:learn_storage/data/local_data_source.dart';
import 'package:learn_storage/domain/repository/theme_repository.dart';
import 'package:learn_storage/domain/repository/todo_repository.dart';

late final TodoRepository repository;
late final ThemeRepository themeRepository;
late final ValueNotifier<ThemeMode> mode;

Future<void> serviceLocator() async {
  /// third party api => storage
  final db = await LocalDataSourceImpl.init;

  /// data
  LocalDataSource dataSource = LocalDataSourceImpl(db: db);

  /// repository
  repository = TodoRepositoryImpl(dataSource: dataSource);
  themeRepository = ThemeRepositoryImpl(dataSource: dataSource);

  /// setting
  mode = ValueNotifier(themeRepository.getMode());
}