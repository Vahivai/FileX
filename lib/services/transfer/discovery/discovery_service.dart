import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/device.dart';
import '../utils/constants.dart';
import 'broadcaster.dart';
import 'listener.dart';

class DiscoveryService {
  final ValueNotifier<List<Device>> devicesNotifier =
      ValueNotifier<List<Device>>([]);

  final DiscoveryBroadcaster _broadcaster = DiscoveryBroadcaster();

  late final DiscoveryListener _listener;

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  List<Device> get devices => devicesNotifier.value;

  Future<void> startDiscovery() async {
    _isSearching = true;

    clearDevices();

    // Temporary device name
    final String deviceName = Platform.isWindows
        ? Platform.localHostname
        : "V2246";

    _listener = DiscoveryListener(
      onMessage: (message, InternetAddress address) {
        // Ignore loopback packets
        if (address.address == InternetAddress.loopbackIPv4.address) {
          return;
        }

        // Ignore our own response
        if (message.deviceName == deviceName) {
          return;
        }

        // Only add response packets
        if (message.type == TransferConstants.responsePrefix) {
          addDevice(
            Device(
              name: message.deviceName,
              ip: address.address,
              port: TransferConstants.discoveryPort,
            ),
          );
        }
      },
    );

    await _listener.startListening();

    await _broadcaster.broadcast(deviceName);

    _isSearching = false;
  }

  void stopDiscovery() {
    _listener.stop();
    _isSearching = false;
  }

  void addDevice(Device device) {
    final updatedDevices = List<Device>.from(devicesNotifier.value);

    if (!updatedDevices.any((d) => d.ip == device.ip)) {
      updatedDevices.add(device);
      devicesNotifier.value = updatedDevices;
    }
  }

  void clearDevices() {
    devicesNotifier.value = [];
  }
}