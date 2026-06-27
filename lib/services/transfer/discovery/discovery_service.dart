import '../models/device.dart';

class DiscoveryService {
  final List<Device> _devices = [];

  List<Device> get devices => List.unmodifiable(_devices);

  void addDevice(Device device) {
    if (!_devices.any((d) => d.ip == device.ip)) {
      _devices.add(device);
    }
  }

  void removeDevice(Device device) {
    _devices.removeWhere((d) => d.ip == device.ip);
  }

  void clearDevices() {
    _devices.clear();
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
  }
}