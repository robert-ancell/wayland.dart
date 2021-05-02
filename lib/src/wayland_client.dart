import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class WaylandClient {
  Socket? _socket;

  /// Creates a new Wayland client.
  /// Call [connect] or [connectToSocket] to connect to a Wayland server.
  WaylandClient() {
  }

  /// Connects to the Wayland server.
  /// The server location is determined from the `WAYLAND_DISPLAY` environment variable.
  ///
  /// If you need to choose the server details use [connectToSocket].
  Future<void> connect() async {
    var display = Platform.environment['WAYLAND_DISPLAY'];
    if (display == null) {
      display = 'wayland-0';
    }

    // FIXME: Use /var/run/user/$pid/$display' if not absolute

    await connectToSocket(display);
  }

  /// Connects to the Wayland server on a socket on [path].
  Future<void> connectToSocket(String path) async {
    var socketAddress = InternetAddress(path, type: InternetAddressType.unix);
    _socket = await Socket.connect(socketAddress, 0);
    _socket?.listen(_processData);
  }

  void _processData(Uint8List data) {
  }
}
