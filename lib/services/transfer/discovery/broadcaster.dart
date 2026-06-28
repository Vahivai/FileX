import 'dart:convert';
import 'dart:io';

import '../utils/constants.dart';

class DiscoveryBroadcaster {
  Future<void> broadcast() async {
    final socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      0,
    );

    socket.broadcastEnabled = true;

    socket.send(
      utf8.encode(TransferConstants.discoveryPrefix),
      InternetAddress("255.255.255.255"),
      TransferConstants.discoveryPort,
    );

    print("📡 Discovery broadcast sent");

    socket.close();
  }
}