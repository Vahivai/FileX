import 'dart:convert';
import 'dart:io';

class DiscoveryBroadcaster {
  static const int discoveryPort = 8888;

  Future<void> broadcast() async {
    final socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      0,
    );

    socket.broadcastEnabled = true;

    const message = "FILEX_DISCOVERY";

    socket.send(
      utf8.encode(message),
      InternetAddress("255.255.255.255"),
      discoveryPort,
    );

    print("📡 Discovery broadcast sent");

    socket.close();
  }
}