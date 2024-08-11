import 'package:flutter/material.dart';
import 'package:routine_app/pages/entryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EntryPage(),
    );
  }
}