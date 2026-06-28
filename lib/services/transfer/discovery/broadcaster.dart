import 'dart:convert';
import 'dart:io';

import '../utils/constants.dart';

class DiscoveryBroadcaster {
  Future<void> broadcast(String deviceName) async {
    final socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      0,
    );

    socket.broadcastEnabled = true;

    final message =
        "${TransferConstants.discoveryPrefix}|$deviceName";

    socket.send(
      utf8.encode(message),
      InternetAddress("255.255.255.255"),
      TransferConstants.discoveryPort,
    );

    print("📡 Sent: $message");

    socket.close();
  }
}