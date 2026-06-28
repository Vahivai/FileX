import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/device.dart';
import 'broadcaster.dart';
import 'listener.dart';

class DiscoveryService {
  final ValueNotifier<List<Device>> devicesNotifier =
      ValueNotifier<List<Device>>([]);

  bool _isSearching = false;

  final DiscoveryBroadcaster _broadcaster = DiscoveryBroadcaster();

  late final DiscoveryListener _listener;

  bool get isSearching => _isSearching;

  List<Device> get devices => devicesNotifier.value;

  Future<void> startDiscovery() async {
  _isSearching = true;

  clearDevices();

  _listener = DiscoveryListener(
    onMessage: (message, InternetAddress address) {
      addDevice(
        Device(
          name: address.address,
          ip: address.address,
          port: 8888,
        ),
      );
    },
  );

  await _listener.startListening();

  await _broadcaster.broadcast(Platform.localHostname);
}

  void stopDiscovery() {
  _listener.stop();

  _isSearching = false;
}

  void addDevice(Device device) {
    final devices = List<Device>.from(devicesNotifier.value);

    if (!devices.any((d) => d.ip == device.ip)) {
      devices.add(device);
      devicesNotifier.value = devices;
    }
  }

  void clearDevices() {
    devicesNotifier.value = [];
  }

  void loadSampleDevices() {
    clearDevices();

    addDevice(
      const Device(
        name: "Abdul-PC",
        ip: "192.168.1.10",
        port: 8888,
      ),
    );

    addDevice(
      const Device(
        name: "Office Laptop",
        ip: "192.168.1.20",
        port: 8888,
      ),
    );

    addDevice(
      const Device(
        name: "Galaxy Phone",
        ip: "192.168.1.30",
        port: 8888,
      ),
    );

    _isSearching = false;
  }
}