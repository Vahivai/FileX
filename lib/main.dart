import 'package:flutter/material.dart';

void main() {
  runApp(const FileXApp());
}

class FileXApp extends StatelessWidget {
  const FileXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FileX',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FileX'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: const [
          Card(
            child: Center(child: Text('📤 Send Files')),
          ),
          Card(
            child: Center(child: Text('📥 Receive Files')),
          ),
          Card(
            child: Center(child: Text('📜 History')),
          ),
          Card(
            child: Center(child: Text('⚙️ Settings')),
          ),
        ],
      ),
    );
  }
}