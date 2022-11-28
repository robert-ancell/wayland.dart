import 'package:wayland/wayland.dart';

void main() async {
  var client = WaylandClient();
  await client.connect();

  var surface = client.compositor!.createSurface();
  var xdgSurface = client.xdgWmBase!.getXdgSurface(surface);
  var toplevel = xdgSurface.getToplevel();
  toplevel.setTitle('Hello World');
  toplevel.setMinSize(400, 400);

  //await client.close();
}
