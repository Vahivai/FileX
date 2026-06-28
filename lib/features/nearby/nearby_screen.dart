import 'package:flutter/material.dart';

import '../../services/transfer/discovery/discovery_service.dart';
import '../../services/transfer/models/device.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final DiscoveryService discoveryService = DiscoveryService();

  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    setState(() {
      isSearching = true;
    });

    await discoveryService.startDiscovery();

    if (!mounted) return;

    setState(() {
      isSearching = false;
    });
  }

  @override
  void dispose() {
    discoveryService.stopDiscovery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Devices"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _startDiscovery,
          ),
        ],
      ),
      body: isSearching
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    "Searching for nearby devices...",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : ValueListenableBuilder<List<Device>>(
              valueListenable: discoveryService.devicesNotifier,
              builder: (context, devices, child) {
                if (devices.isEmpty) {
                  return const Center(
                    child: Text(
                      "No nearby devices found",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(
                          Icons.computer,
                          color: Colors.blue,
                          size: 32,
                        ),
                        title: Text(
                          device.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${device.ip}:${device.port}",
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Connecting to ${device.name}...",
                                ),
                              ),
                            );
                          },
                          child: const Text("Connect"),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}