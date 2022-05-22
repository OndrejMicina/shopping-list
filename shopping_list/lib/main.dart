import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list/home_page.dart';
import 'package:shopping_list/models/grocery_list_model.dart';

import 'models/grocery_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GroceryListAdapter());
  Hive.registerAdapter(GroceryAdapter());
  await Hive.openBox('userLists');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My lists'),
    );
  }
}
