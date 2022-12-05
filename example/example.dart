import 'package:wayland/wayland.dart';

final width = 400;
final height = 400;

late WaylandClient client;
late WaylandRegistry registry;
WaylandCompositor? compositor;
WaylandShm? shm;
XdgWmBase? wmBase;

void main() async {
  client = WaylandClient();
  await client.connect();

  registry = client.getRegistry(onGlobal: (name, interface, version) {
    switch (interface) {
      case 'wl_compositor':
        compositor =
            WaylandCompositor(client, registry.bind(name, interface, version));
        break;
      case 'wl_shm':
        shm = WaylandShm(client, registry.bind(name, interface, version));
        break;
      case 'xdg_wm_base':
        wmBase = XdgWmBase(client, registry.bind(name, interface, version),
            onPing: (serial) => wmBase!.pong(serial));
        break;
    }
  });
  client.sync((_) {
    var surface = compositor!.createSurface();
    XdgSurface? xdgSurface;
    xdgSurface = wmBase!.getXdgSurface(surface,
        onConfigure: (serial) => xdgSurface!.ackConfigure(serial));
    var toplevel = xdgSurface.getToplevel();
    toplevel.setTitle('Hello World');
    toplevel.setMinSize(width, height);
    surface.commit();
  });

  //await client.close();
}
