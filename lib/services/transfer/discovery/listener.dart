import 'dart:convert';
import 'dart:io';
import '../utils/constants.dart';
import '../models/discovery_message.dart';

class DiscoveryListener {
  final void Function(
  DiscoveryMessage message,
  InternetAddress address,
  )? onMessage;

  DiscoveryListener({this.onMessage});

  RawDatagramSocket? _socket;

  Future<void> startListening() async {
    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      TransferConstants.discoveryPort,
    );

    print("🎧 Listening on port ${TransferConstants.discoveryPort}");

    _socket!.listen((event) async {
      if (event != RawSocketEvent.read) return;

      final datagram = _socket!.receive();

      if (datagram == null) return;

      if (datagram.address.address == InternetAddress.loopbackIPv4.address) {
        return;
      }

      final rawMessage = utf8.decode(datagram.data);

      print("Received: $rawMessage");

      final message = DiscoveryMessage.fromString(rawMessage);

      onMessage?.call(message, datagram.address);

      // Someone is searching for devices
      if (message.type == TransferConstants.discoveryPrefix) {
        String deviceName = Platform.isAndroid
            ? "V2246"
            : Platform.localHostname;

        final response =
            "${TransferConstants.responsePrefix}|$deviceName";

        _socket!.send(
          utf8.encode(response),
          datagram.address,
          TransferConstants.discoveryPort,
        );
      }
    });
  }

  void stop() {
    _socket?.close();
  }
}