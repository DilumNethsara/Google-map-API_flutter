import 'package:flutter/material.dart';
import 'package:project2/mongodb.dart';
import 'package:project2/pages/map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    MongoDatabase.connect();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DisplayMap());
  }
}
