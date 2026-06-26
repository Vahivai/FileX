import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(2)} KB";
    if (bytes < 1024 * 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
    }
    return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Files"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: selectedFile == null
              ? ElevatedButton.icon(
                  onPressed: pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Choose File"),
                )
              : Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.insert_drive_file,
                          size: 70,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          selectedFile!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          formatBytes(selectedFile!.size),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: pickFile,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Choose Another File"),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}