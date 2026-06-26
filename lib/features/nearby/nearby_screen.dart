import 'package:flutter/material.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = [
      {
        "name": "Abdul-PC",
        "ip": "192.168.1.10",
        "icon": Icons.computer,
      },
      {
        "name": "Office Laptop",
        "ip": "192.168.1.20",
        "icon": Icons.laptop,
      },
      {
        "name": "Galaxy Phone",
        "ip": "192.168.1.30",
        "icon": Icons.phone_android,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Devices"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                device["icon"] as IconData,
                color: Colors.blue,
                size: 32,
              ),
              title: Text(
                device["name"] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(device["ip"] as String),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Connecting to ${device["name"]}...",
                      ),
                    ),
                  );
                },
                child: const Text("Connect"),
              ),
            ),
          );
        },
      ),
    );
  }
}