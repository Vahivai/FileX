import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';

class FileXApp extends StatelessWidget {
  const FileXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FileX',
      home: const HomeScreen(),
    );
  }
}