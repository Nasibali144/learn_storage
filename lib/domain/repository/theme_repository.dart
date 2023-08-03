import 'package:flutter/material.dart';
import 'package:learn_storage/data/local_data_source.dart';

abstract class ThemeRepository {
  ThemeMode getMode();
  Future<void> setMode(ThemeMode mode);
}

class ThemeRepositoryImpl implements ThemeRepository {

  final LocalDataSource dataSource;
  const ThemeRepositoryImpl({required this.dataSource});

  @override
  ThemeMode getMode() {
    final result = dataSource.read(StorageKey.mode) ?? ThemeMode.light.name;
    return _stringToMode(result);
  }

  @override
  Future<bool> setMode(ThemeMode mode) {
    return dataSource.store(StorageKey.mode, mode.name);
  }

  ThemeMode _stringToMode(String value) {
    switch(value) {
      case "light": return ThemeMode.light;
      case "dark": return ThemeMode.dark;
      case "system": return ThemeMode.system;
      default: return ThemeMode.light;
    }
  }
}


