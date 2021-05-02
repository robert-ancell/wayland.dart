import 'package:wayland/wayland.dart';

void main() async {
  var client = WaylandClient();
  await client.connect();

  // FIXME

  await client.close();
}
