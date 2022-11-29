import 'package:wayland/wayland.dart';

void main() async {
  var client = WaylandClient();
  await client.connect();

  var surface = client.compositor!.createSurface();
  XdgSurface? xdgSurface;
  xdgSurface = client.xdgWmBase!.getXdgSurface(surface,
      onConfigure: (serial) => xdgSurface!.ackConfigure(serial));
  var toplevel = xdgSurface.getToplevel();
  toplevel.setTitle('Hello World');
  toplevel.setMinSize(400, 400);

  //await client.close();
}
