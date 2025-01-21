import 'package:flutter/material.dart';
import 'homefolderscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeFolderScreen(),
    );
  }
}
