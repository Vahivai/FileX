class DiscoveryMessage {
  final String type;
  final String deviceName;

  const DiscoveryMessage({
    required this.type,
    required this.deviceName,
  });

  factory DiscoveryMessage.fromString(String message) {
    final parts = message.split('|');

    return DiscoveryMessage(
      type: parts[0],
      deviceName: parts.length > 1 ? parts[1] : '',
    );
  }

  @override
  String toString() {
    return '$type|$deviceName';
  }
}