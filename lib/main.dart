import 'package:flutter/material.dart';
import 'package:learn_storage/services/pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const LearnSharedPreferences());
}

class LearnSharedPreferences extends StatelessWidget {
  const LearnSharedPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      themeMode: ThemeMode.light,
      home: HomeSharedPreferences(),
    );
  }
}

class HomeSharedPreferences extends StatefulWidget {
  const HomeSharedPreferences({Key? key}) : super(key: key);

  @override
  State<HomeSharedPreferences> createState() => _HomeSharedPreferencesState();
}

class _HomeSharedPreferencesState extends State<HomeSharedPreferences> {

  String data = "";

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    data = await Prefs.read(StorageKey.data) ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Read and write"),),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// write
              TextField(
                decoration: const InputDecoration(
                  hintText: "Write Data"
                ),
                style: Theme.of(context).textTheme.headlineMedium,
                onSubmitted: (data) async {
                  await Prefs.store(StorageKey.data, data).whenComplete(load);
                },
              ),

              /// read
              Text(data, style: Theme.of(context).textTheme.headlineLarge,),
            ],
          ),
        ),
      ),
    );
  }
}




