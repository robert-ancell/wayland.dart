import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

enum WaylandShmFormat {
  argb8888,
  xrgb8888,
  c8,
  rgb332,
  bgr233,
  xrgb4444,
  xbgr4444,
  rgbx4444,
  bgrx4444,
  argb4444,
  abgr4444,
  rgba4444,
  bgra4444,
  xrgb1555,
  xbgr1555,
  rgbx5551,
  bgrx5551,
  argb1555,
  abgr1555,
  rgba5551,
  bgra5551,
  rgb565,
  bgr565,
  rgb888,
  bgr888,
  xbgr8888,
  rgbx8888,
  bgrx8888,
  abgr8888,
  rgba8888,
  bgra8888,
  xrgb2101010,
  xbgr2101010,
  rgbx1010102,
  bgrx1010102,
  argb2101010,
  abgr2101010,
  rgba1010102,
  bgra1010102,
  yuyv,
  yvyu,
  uyvy,
  vyuy,
  ayuv,
  nv12,
  nv21,
  nv16,
  nv61,
  yuv410,
  yvu410,
  yuv411,
  yvu411,
  yuv420,
  yvu420,
  yuv422,
  yvu422,
  yuv444,
  yvu444,
  r8,
  r16,
  rg88,
  gr88,
  rg1616,
  gr1616,
  xrgb16161616f,
  xbgr16161616f,
  argb16161616f,
  abgr16161616f,
  xyuv8888,
  vuy888,
  vuy101010,
  y210,
  y212,
  y216,
  y410,
  y412,
  y416,
  xvyu2101010,
  xvyu12_16161616,
  xvyu16161616,
  y0l0,
  x0l0,
  y0l2,
  x0l2,
  yuv420_8bit,
  yuv420_10bit,
  xrgb8888_a8,
  xbgr8888_a8,
  rgbx8888_a8,
  bgrx8888_a8,
  rgb888_a8,
  bgr888_a8,
  rgb565_a8,
  bgr565_a8,
  nv24,
  nv42,
  p210,
  p010,
  p012,
  p016,
  axbxgxrx106106106106,
  nv15,
  q410,
  q401,
  xrgb16161616,
  xbgr16161616,
  argb16161616,
  abgr16161616
}

int _encodeShmFormat(WaylandShmFormat format) {
  return {
        WaylandShmFormat.argb8888: 0,
        WaylandShmFormat.xrgb8888: 1,
        WaylandShmFormat.c8: 0x20203843,
        WaylandShmFormat.rgb332: 0x38424752,
        WaylandShmFormat.bgr233: 0x38524742,
        WaylandShmFormat.xrgb4444: 0x32315258,
        WaylandShmFormat.xbgr4444: 0x32314258,
        WaylandShmFormat.rgbx4444: 0x32315852,
        WaylandShmFormat.bgrx4444: 0x32315842,
        WaylandShmFormat.argb4444: 0x32315241,
        WaylandShmFormat.abgr4444: 0x32314241,
        WaylandShmFormat.rgba4444: 0x32314152,
        WaylandShmFormat.bgra4444: 0x32314142,
        WaylandShmFormat.xrgb1555: 0x35315258,
        WaylandShmFormat.xbgr1555: 0x35314258,
        WaylandShmFormat.rgbx5551: 0x35315852,
        WaylandShmFormat.bgrx5551: 0x35315842,
        WaylandShmFormat.argb1555: 0x35315241,
        WaylandShmFormat.abgr1555: 0x35314241,
        WaylandShmFormat.rgba5551: 0x35314152,
        WaylandShmFormat.bgra5551: 0x35314142,
        WaylandShmFormat.rgb565: 0x36314752,
        WaylandShmFormat.bgr565: 0x36314742,
        WaylandShmFormat.rgb888: 0x34324752,
        WaylandShmFormat.bgr888: 0x34324742,
        WaylandShmFormat.xbgr8888: 0x34324258,
        WaylandShmFormat.rgbx8888: 0x34325852,
        WaylandShmFormat.bgrx8888: 0x34325842,
        WaylandShmFormat.abgr8888: 0x34324241,
        WaylandShmFormat.rgba8888: 0x34324152,
        WaylandShmFormat.bgra8888: 0x34324142,
        WaylandShmFormat.xrgb2101010: 0x30335258,
        WaylandShmFormat.xbgr2101010: 0x30334258,
        WaylandShmFormat.rgbx1010102: 0x30335852,
        WaylandShmFormat.bgrx1010102: 0x30335842,
        WaylandShmFormat.argb2101010: 0x30335241,
        WaylandShmFormat.abgr2101010: 0x30334241,
        WaylandShmFormat.rgba1010102: 0x30334152,
        WaylandShmFormat.bgra1010102: 0x30334142,
        WaylandShmFormat.yuyv: 0x56595559,
        WaylandShmFormat.yvyu: 0x55595659,
        WaylandShmFormat.uyvy: 0x59565955,
        WaylandShmFormat.vyuy: 0x59555956,
        WaylandShmFormat.ayuv: 0x56555941,
        WaylandShmFormat.nv12: 0x3231564e,
        WaylandShmFormat.nv21: 0x3132564e,
        WaylandShmFormat.nv16: 0x3631564e,
        WaylandShmFormat.nv61: 0x3136564e,
        WaylandShmFormat.yuv410: 0x39565559,
        WaylandShmFormat.yvu410: 0x39555659,
        WaylandShmFormat.yuv411: 0x31315559,
        WaylandShmFormat.yvu411: 0x31315659,
        WaylandShmFormat.yuv420: 0x32315559,
        WaylandShmFormat.yvu420: 0x32315659,
        WaylandShmFormat.yuv422: 0x36315559,
        WaylandShmFormat.yvu422: 0x36315659,
        WaylandShmFormat.yuv444: 0x34325559,
        WaylandShmFormat.yvu444: 0x34325659,
        WaylandShmFormat.r8: 0x20203852,
        WaylandShmFormat.r16: 0x20363152,
        WaylandShmFormat.rg88: 0x38384752,
        WaylandShmFormat.gr88: 0x38385247,
        WaylandShmFormat.rg1616: 0x32334752,
        WaylandShmFormat.gr1616: 0x32335247,
        WaylandShmFormat.xrgb16161616f: 0x48345258,
        WaylandShmFormat.xbgr16161616f: 0x48344258,
        WaylandShmFormat.argb16161616f: 0x48345241,
        WaylandShmFormat.abgr16161616f: 0x48344241,
        WaylandShmFormat.xyuv8888: 0x56555958,
        WaylandShmFormat.vuy888: 0x34325556,
        WaylandShmFormat.vuy101010: 0x30335556,
        WaylandShmFormat.y210: 0x30313259,
        WaylandShmFormat.y212: 0x32313259,
        WaylandShmFormat.y216: 0x36313259,
        WaylandShmFormat.y410: 0x30313459,
        WaylandShmFormat.y412: 0x32313459,
        WaylandShmFormat.y416: 0x36313459,
        WaylandShmFormat.xvyu2101010: 0x30335658,
        WaylandShmFormat.xvyu12_16161616: 0x36335658,
        WaylandShmFormat.xvyu16161616: 0x38345658,
        WaylandShmFormat.y0l0: 0x304c3059,
        WaylandShmFormat.x0l0: 0x304c3058,
        WaylandShmFormat.y0l2: 0x324c3059,
        WaylandShmFormat.x0l2: 0x324c3058,
        WaylandShmFormat.yuv420_8bit: 0x38305559,
        WaylandShmFormat.yuv420_10bit: 0x30315559,
        WaylandShmFormat.xrgb8888_a8: 0x38415258,
        WaylandShmFormat.xbgr8888_a8: 0x38414258,
        WaylandShmFormat.rgbx8888_a8: 0x38415852,
        WaylandShmFormat.bgrx8888_a8: 0x38415842,
        WaylandShmFormat.rgb888_a8: 0x38413852,
        WaylandShmFormat.bgr888_a8: 0x38413842,
        WaylandShmFormat.rgb565_a8: 0x38413552,
        WaylandShmFormat.bgr565_a8: 0x38413542,
        WaylandShmFormat.nv24: 0x3432564e,
        WaylandShmFormat.nv42: 0x3234564e,
        WaylandShmFormat.p210: 0x30313250,
        WaylandShmFormat.p010: 0x30313050,
        WaylandShmFormat.p012: 0x32313050,
        WaylandShmFormat.p016: 0x36313050,
        WaylandShmFormat.axbxgxrx106106106106: 0x30314241,
        WaylandShmFormat.nv15: 0x3531564e,
        WaylandShmFormat.q410: 0x30313451,
        WaylandShmFormat.q401: 0x31303451,
        WaylandShmFormat.xrgb16161616: 0x38345258,
        WaylandShmFormat.xbgr16161616: 0x38344258,
        WaylandShmFormat.argb16161616: 0x38345241,
        WaylandShmFormat.abgr16161616: 0x38344241
      }[format] ??
      -1;
}

WaylandShmFormat? _decodeShmFormat(int value) {
  return {
    0: WaylandShmFormat.argb8888,
    1: WaylandShmFormat.xrgb8888,
    0x20203843: WaylandShmFormat.c8,
    0x38424752: WaylandShmFormat.rgb332,
    0x38524742: WaylandShmFormat.bgr233,
    0x32315258: WaylandShmFormat.xrgb4444,
    0x32314258: WaylandShmFormat.xbgr4444,
    0x32315852: WaylandShmFormat.rgbx4444,
    0x32315842: WaylandShmFormat.bgrx4444,
    0x32315241: WaylandShmFormat.argb4444,
    0x32314241: WaylandShmFormat.abgr4444,
    0x32314152: WaylandShmFormat.rgba4444,
    0x32314142: WaylandShmFormat.bgra4444,
    0x35315258: WaylandShmFormat.xrgb1555,
    0x35314258: WaylandShmFormat.xbgr1555,
    0x35315852: WaylandShmFormat.rgbx5551,
    0x35315842: WaylandShmFormat.bgrx5551,
    0x35315241: WaylandShmFormat.argb1555,
    0x35314241: WaylandShmFormat.abgr1555,
    0x35314152: WaylandShmFormat.rgba5551,
    0x35314142: WaylandShmFormat.bgra5551,
    0x36314752: WaylandShmFormat.rgb565,
    0x36314742: WaylandShmFormat.bgr565,
    0x34324752: WaylandShmFormat.rgb888,
    0x34324742: WaylandShmFormat.bgr888,
    0x34324258: WaylandShmFormat.xbgr8888,
    0x34325852: WaylandShmFormat.rgbx8888,
    0x34325842: WaylandShmFormat.bgrx8888,
    0x34324241: WaylandShmFormat.abgr8888,
    0x34324152: WaylandShmFormat.rgba8888,
    0x34324142: WaylandShmFormat.bgra8888,
    0x30335258: WaylandShmFormat.xrgb2101010,
    0x30334258: WaylandShmFormat.xbgr2101010,
    0x30335852: WaylandShmFormat.rgbx1010102,
    0x30335842: WaylandShmFormat.bgrx1010102,
    0x30335241: WaylandShmFormat.argb2101010,
    0x30334241: WaylandShmFormat.abgr2101010,
    0x30334152: WaylandShmFormat.rgba1010102,
    0x30334142: WaylandShmFormat.bgra1010102,
    0x56595559: WaylandShmFormat.yuyv,
    0x55595659: WaylandShmFormat.yvyu,
    0x59565955: WaylandShmFormat.uyvy,
    0x59555956: WaylandShmFormat.vyuy,
    0x56555941: WaylandShmFormat.ayuv,
    0x3231564e: WaylandShmFormat.nv12,
    0x3132564e: WaylandShmFormat.nv21,
    0x3631564e: WaylandShmFormat.nv16,
    0x3136564e: WaylandShmFormat.nv61,
    0x39565559: WaylandShmFormat.yuv410,
    0x39555659: WaylandShmFormat.yvu410,
    0x31315559: WaylandShmFormat.yuv411,
    0x31315659: WaylandShmFormat.yvu411,
    0x32315559: WaylandShmFormat.yuv420,
    0x32315659: WaylandShmFormat.yvu420,
    0x36315559: WaylandShmFormat.yuv422,
    0x36315659: WaylandShmFormat.yvu422,
    0x34325559: WaylandShmFormat.yuv444,
    0x34325659: WaylandShmFormat.yvu444,
    0x20203852: WaylandShmFormat.r8,
    0x20363152: WaylandShmFormat.r16,
    0x38384752: WaylandShmFormat.rg88,
    0x38385247: WaylandShmFormat.gr88,
    0x32334752: WaylandShmFormat.rg1616,
    0x32335247: WaylandShmFormat.gr1616,
    0x48345258: WaylandShmFormat.xrgb16161616f,
    0x48344258: WaylandShmFormat.xbgr16161616f,
    0x48345241: WaylandShmFormat.argb16161616f,
    0x48344241: WaylandShmFormat.abgr16161616f,
    0x56555958: WaylandShmFormat.xyuv8888,
    0x34325556: WaylandShmFormat.vuy888,
    0x30335556: WaylandShmFormat.vuy101010,
    0x30313259: WaylandShmFormat.y210,
    0x32313259: WaylandShmFormat.y212,
    0x36313259: WaylandShmFormat.y216,
    0x30313459: WaylandShmFormat.y410,
    0x32313459: WaylandShmFormat.y412,
    0x36313459: WaylandShmFormat.y416,
    0x30335658: WaylandShmFormat.xvyu2101010,
    0x36335658: WaylandShmFormat.xvyu12_16161616,
    0x38345658: WaylandShmFormat.xvyu16161616,
    0x304c3059: WaylandShmFormat.y0l0,
    0x304c3058: WaylandShmFormat.x0l0,
    0x324c3059: WaylandShmFormat.y0l2,
    0x324c3058: WaylandShmFormat.x0l2,
    0x38305559: WaylandShmFormat.yuv420_8bit,
    0x30315559: WaylandShmFormat.yuv420_10bit,
    0x38415258: WaylandShmFormat.xrgb8888_a8,
    0x38414258: WaylandShmFormat.xbgr8888_a8,
    0x38415852: WaylandShmFormat.rgbx8888_a8,
    0x38415842: WaylandShmFormat.bgrx8888_a8,
    0x38413852: WaylandShmFormat.rgb888_a8,
    0x38413842: WaylandShmFormat.bgr888_a8,
    0x38413552: WaylandShmFormat.rgb565_a8,
    0x38413542: WaylandShmFormat.bgr565_a8,
    0x3432564e: WaylandShmFormat.nv24,
    0x3234564e: WaylandShmFormat.nv42,
    0x30313250: WaylandShmFormat.p210,
    0x30313050: WaylandShmFormat.p010,
    0x32313050: WaylandShmFormat.p012,
    0x36313050: WaylandShmFormat.p016,
    0x30314241: WaylandShmFormat.axbxgxrx106106106106,
    0x3531564e: WaylandShmFormat.nv15,
    0x30313451: WaylandShmFormat.q410,
    0x31303451: WaylandShmFormat.q401,
    0x38345258: WaylandShmFormat.xrgb16161616,
    0x38344258: WaylandShmFormat.xbgr16161616,
    0x38345241: WaylandShmFormat.argb16161616,
    0x38344241: WaylandShmFormat.abgr16161616
  }[value];
}

class WaylandClient {
  Socket? _socket;

  final _buffer = <int>[];

  late final WaylandDisplay _display;
  late final WaylandRegistry _registry;
  WaylandCompositor? _compositor;
  WaylandShm? _shm;
  XdgWmBase? _xdgWmBase;
  final _objects = <int, WaylandObject>{};
  int _nextId = 2;

  /// Creates a new Wayland client.
  /// Call [connect] to connect to a Wayland server.
  WaylandClient();

  /// Connects to the Wayland server.
  /// If [name] is not provided the display name is determined from the `WAYLAND_DISPLAY` environment variable.
  ///
  /// If you need to choose the server details use [connectToSocket].
  Future<void> connect({String? name}) async {
    name ??= Platform.environment['WAYLAND_DISPLAY'] ?? 'wayland-0';
    String path;
    if (name.startsWith('/')) {
      path = name;
    } else {
      var runtimeDir = Platform.environment['XDG_RUNTIME_DIR'];
      if (runtimeDir == null) {
        throw Exception('Unable to determine XDG_RUNTIME_DIR');
      }
      path = '$runtimeDir/$name';
    }
    await _connectToSocket(path);

    _display = WaylandDisplay(this);
    _registry = _display.getRegistry();
  }

  /// Connects to the Wayland server on a socket on [path].
  Future<void> _connectToSocket(String path) async {
    var socketAddress = InternetAddress(path, type: InternetAddressType.unix);
    _socket = await Socket.connect(socketAddress, 0);
    _socket?.listen(_processData);
  }

  /// Closes the connection to the server.
  Future<void> close() async {
    await _socket?.close();
  }

  void _processData(Uint8List data) {
    _buffer.addAll(data);

    while (true) {
      if (_buffer.length < 8) {
        return;
      }

      var buffer =
          _WaylandReadBuffer(Uint8List.fromList(_buffer.sublist(0, 8)));
      var id = buffer.readUint();
      var codeAndLength = buffer.readUint();
      var length = codeAndLength >> 16;
      var code = codeAndLength & 0xffff;
      assert(length >= 8);
      if (_buffer.length < length) {
        return;
      }
      // FIXME: Do without copying
      var payload = Uint8List.fromList(_buffer.sublist(8, length));

      _processEvent(id, code, payload);
      _buffer.removeRange(0, length);
    }
  }

  void _processEvent(int id, int code, Uint8List payload) {
    var object = _objects[id];
    if (object != null) {
      object.processEvent(code, payload);
    } else {
      print('$id::$code $payload');
    }
  }

  int _getNextId() {
    var id = _nextId;
    _nextId++;
    return id;
  }

  void _sendRequest(int objectId, int code, Uint8List payload) {
    var length = 8 + payload.length;
    var header = _WaylandWriteBuffer();
    header.writeUint(objectId);
    header.writeUint(length << 16 | code);
    _socket?.add(header.data);
    _socket?.add(payload);
  }
}

class _WaylandReadBuffer {
  var _offset = 0;
  final Uint8List _data;

  _WaylandReadBuffer(Uint8List data) : _data = data;

  int readUint() {
    assert(_data.length >= _offset + 4);
    var value = _data[_offset + 3] << 24 |
        _data[_offset + 2] << 16 |
        _data[_offset + 1] << 8 |
        _data[_offset + 0];
    _offset += 4;
    return value;
  }

  String readString() {
    var length = readUint();
    var paddedLength = length;
    if (paddedLength % 4 != 0) {
      paddedLength += 4 - (paddedLength % 4);
    }

    assert(length >= 1 && _data.length >= _offset + paddedLength);
    var value = utf8.decode(_data.sublist(_offset, _offset + length - 1));

    // Must be nul terminated.
    assert(_data[_offset + length - 1] == 0x00);
    _offset += length;

    // Skip padding.
    for (var i = length; i < paddedLength; i++) {
      assert(_data[_offset] == 0x00);
      _offset++;
    }

    return value;
  }
}

class _WaylandWriteBuffer {
  final _data = <int>[];
  final _fds = <int>[];

  Uint8List get data => Uint8List.fromList(_data);

  void writeInt(int value) {
    var bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setInt32(0, value, Endian.little);
    _data.addAll(bytes);
  }

  void writeUint(int value) {
    var bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setUint32(0, value, Endian.little);
    _data.addAll(bytes);
  }

  void writeString(String value) {
    var utf8Data = utf8.encode(value);
    var length = utf8Data.length + 1;
    writeUint(length);
    for (var d in utf8Data) {
      _data.add(d);
    }
    _data.add(0x00);
    // Pad to 32 bit boundary.
    while (length % 4 != 0) {
      _data.add(0x00);
      length++;
    }
  }

  void writeFd(int fd) {
    _fds.add(fd);
  }
}

abstract class WaylandObject {
  final WaylandClient client;
  final int id;

  WaylandObject(this.client, this.id) {
    client._objects[id] = this;
  }

  void processEvent(int code, Uint8List payload);
}

class WaylandDisplay extends WaylandObject {
  WaylandDisplay(WaylandClient client) : super(client, 1);

  void sync() {
    var callback = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(callback);
    client._sendRequest(id, 0, payload.data);
  }

  WaylandRegistry getRegistry() {
    var registry = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(registry);
    client._sendRequest(id, 1, payload.data);
    return WaylandRegistry(client, registry);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = _WaylandReadBuffer(payload);
        var objectId = buffer.readUint();
        var errorCode = buffer.readUint();
        var message = buffer.readString();
        // Codes: { 0: invalidObject, 1: invalidMethod, 2: noMemory, 3: implementation }
        print('wl_display::error $objectId $errorCode $message');
        break;
      case 1:
        var buffer = _WaylandReadBuffer(payload);
        var id = buffer.readUint();
        print('wl_display::delete_id $id');
        break;
      default:
        print('wl_display::$code $payload');
        break;
    }
  }
}

class WaylandRegistry extends WaylandObject {
  WaylandRegistry(WaylandClient client, int id) : super(client, id);

  int bind(int name, String interface, int version) {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(name);
    payload.writeString(interface);
    payload.writeUint(version);
    payload.writeUint(id);
    client._sendRequest(this.id, 0, payload.data);
    return id;
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = _WaylandReadBuffer(payload);
        var name = buffer.readUint();
        var interface = buffer.readString();
        var version = buffer.readUint();
        print('wl_registry::global $name $interface $version');

        switch (interface) {
          case 'wl_compositor':
            client._compositor =
                WaylandCompositor(client, bind(name, interface, version));
            break;
          case 'wl_shm':
            client._shm = WaylandShm(client, bind(name, interface, version));
            break;
          case 'xdg_wm_base':
            client._xdgWmBase =
                XdgWmBase(client, bind(name, interface, version));
            break;
        }
        break;
      case 1:
        var buffer = _WaylandReadBuffer(payload);
        var name = buffer.readUint();
        print('wl_registry::global_remove $name');
        break;
      default:
        print('wl_registry::$code $payload');
        break;
    }
  }
}

class WaylandCompositor extends WaylandObject {
  WaylandCompositor(WaylandClient client, int id) : super(client, id);

  WaylandSurface createSurface() {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    client._sendRequest(id, 0, payload.data);
    return WaylandSurface(client, id);
  }

  int createRegion() {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    client._sendRequest(id, 1, payload.data);
    return id;
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('wl_compositor::$code $payload');
        break;
    }
  }
}

class WaylandShmPool extends WaylandObject {
  WaylandShmPool(WaylandClient client, int id) : super(client, id);

  WaylandBuffer createBuffer(
      {int offset = 0,
      required int width,
      required int height,
      required int stride,
      required WaylandShmFormat format}) {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeInt(offset);
    payload.writeInt(width);
    payload.writeInt(height);
    payload.writeInt(stride);
    payload.writeUint(_encodeShmFormat(format));
    client._sendRequest(id, 0, payload.data);
    return WaylandBuffer(client, id);
  }

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 1, payload.data);
  }

  void resize(int size) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(size);
    client._sendRequest(id, 2, payload.data);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('wl_shm_pool::$code $payload');
        break;
    }
  }
}

class WaylandShm extends WaylandObject {
  final formats = <WaylandShmFormat>[];

  WaylandShm(WaylandClient client, int id) : super(client, id);

  WaylandShmPool createPool(int fd, int size) {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeFd(fd);
    payload.writeUint(size);
    client._sendRequest(id, 0, payload.data);
    return WaylandShmPool(client, id);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = _WaylandReadBuffer(payload);
        var format = _decodeShmFormat(buffer.readUint());
        print('wl_shm::format $format');
        if (format != null) {
          formats.add(format);
        }
        break;
      default:
        print('wl_shm::$code $payload');
        break;
    }
  }
}

class WaylandBuffer extends WaylandObject {
  WaylandBuffer(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        print('wl_buffer::release');
        break;
      default:
        print('wl_buffer::$code $payload');
        break;
    }
  }
}

class WaylandSurface extends WaylandObject {
  WaylandSurface(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  void attach(WaylandBuffer buffer, int x, int y) {
    var payload = _WaylandWriteBuffer();
    payload.writeUint(buffer.id);
    payload.writeInt(x);
    payload.writeInt(y);
    client._sendRequest(id, 1, payload.data);
  }

  void damage(int x, int y, int width, int height) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client._sendRequest(id, 2, payload.data);
  }

  // ...

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        // FIXME: output
        print('wl_buffer::enter');
        break;
      case 1:
        // FIXME: output
        print('wl_buffer::leave');
        break;
      default:
        print('wl_surfacer::$code $payload');
        break;
    }
  }
}

class WaylandRegion extends WaylandObject {
  WaylandRegion(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  void add(int x, int y, int width, int height) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client._sendRequest(id, 1, payload.data);
  }

  void subtract(int x, int y, int width, int height) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client._sendRequest(id, 2, payload.data);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('wl_region::$code $payload');
        break;
    }
  }
}

class XdgWmBase extends WaylandObject {
  XdgWmBase(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  XdgPositioner createPositioner() {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    client._sendRequest(id, 1, payload.data);
    return XdgPositioner(client, id);
  }

  XdgSurface getXdgSurface(WaylandSurface surface) {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeUint(surface.id);
    client._sendRequest(id, 2, payload.data);
    return XdgSurface(client, id);
  }

  void pong(int serial) {
    var payload = _WaylandWriteBuffer();
    payload.writeUint(serial);
    client._sendRequest(id, 3, payload.data);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = _WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        print('xdg_wm_base::ping $serial');
        pong(serial);
        break;
      default:
        print('xdg_wm_base::$code $payload');
        break;
    }
  }
}

class XdgPositioner extends WaylandObject {
  XdgPositioner(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  void setSize(int width, int height) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(width);
    payload.writeInt(height);
    client._sendRequest(id, 1, payload.data);
  }

  //setAnchorRect

  //setAnchor

  //setGravity

  //setConstraintAdjustment

  //setOffset

  //setReactive

  //setParentSize

  //setParentConfigure

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('xdg_positioner::$code $payload');
        break;
    }
  }
}

class XdgSurface extends WaylandObject {
  XdgSurface(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  XdgToplevel getToplevel() {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    client._sendRequest(id, 1, payload.data);
    return XdgToplevel(client, id);
  }

  int getPopup(int parent, int positioner) {
    var id = client._getNextId();
    var payload = _WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeUint(parent);
    payload.writeUint(positioner);
    client._sendRequest(id, 2, payload.data);
    return id;
  }

  void setWindowGeometry(int x, int y, int width, int height) {
    var payload = _WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client._sendRequest(id, 3, payload.data);
  }

  void ackConfigure(int serial) {
    var payload = _WaylandWriteBuffer();
    payload.writeUint(serial);
    client._sendRequest(id, 4, payload.data);
  }

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('xdg_surface::$code $payload');
        break;
    }
  }
}

class XdgToplevel extends WaylandObject {
  XdgToplevel(WaylandClient client, int id) : super(client, id);

  void destroy() {
    var payload = _WaylandWriteBuffer();
    client._sendRequest(id, 0, payload.data);
  }

  //setParent

  //setTitle

  //setAppId

  //showWindowMenu

  //move

  //resize

  //state

  //setMaxSize

  //setMinSize

  //setMaximized

  //unsetMaximized

  //setFullscreen

  //unsetFullscreen

  //setMiminized

  @override
  void processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        print('xdg_toplevel::$code $payload');
        break;
    }
  }
}
