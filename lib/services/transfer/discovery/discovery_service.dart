import 'dart:async';

class DiscoveryService {
  final StreamController<List<String>> _devicesController =
      StreamController.broadcast();

  Stream<List<String>> get devicesStream => _devicesController.stream;

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  Future<void> startDiscovery() async {
    _isSearching = true;

    // Networking code will be added here.
  }

  void stopDiscovery() {
    _isSearching = false;
    _devicesController.close();
  }
}