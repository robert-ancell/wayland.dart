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

  final _objects = <int, WaylandObject>{};

  // ID 1 is used for the display object.
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
  }

  WaylandCallback sync(Function(int) onDone) {
    return _display.sync(onDone);
  }

  WaylandRegistry getRegistry(
      {Function(int, String, int)? onGlobal, Function(int)? onGlobalRemove}) {
    return _display.getRegistry(
        onGlobal: onGlobal, onGlobalRemove: onGlobalRemove);
  }

  /// Closes the connection to the server.
  Future<void> close() async {
    await _socket?.close();
  }

  /// Connects to the Wayland server on a socket on [path].
  Future<void> _connectToSocket(String path) async {
    var socketAddress = InternetAddress(path, type: InternetAddressType.unix);
    _socket = await Socket.connect(socketAddress, 0);
    _socket?.listen(_processData);
  }

  void _processData(Uint8List data) {
    _buffer.addAll(data);

    while (true) {
      if (_buffer.length < 8) {
        return;
      }

      var buffer = WaylandReadBuffer(Uint8List.fromList(_buffer.sublist(0, 8)));
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
      if (!object.processEvent(code, payload)) {
        print('${object.interfaceName}::$code $payload');
      }
    } else {
      print('$id::$code $payload');
    }
  }

  int _getNextId() {
    var id = _nextId;
    _nextId++;
    return id;
  }

  void sendRequest(int objectId, int code, [Uint8List? payload]) {
    var payloadLength = payload?.length ?? 0;
    var length = 8 + payloadLength;
    var header = WaylandWriteBuffer();
    header.writeUint(objectId);
    header.writeUint(length << 16 | code);
    _socket?.add(header.data);
    if (payload != null) {
      _socket?.add(payload);
    }
  }
}

class WaylandReadBuffer {
  var _offset = 0;
  final Uint8List _data;

  WaylandReadBuffer(Uint8List data) : _data = data;

  int readInt() {
    assert(_data.length >= _offset + 4);
    var value = ByteData.view(_data.buffer).getInt32(_offset, Endian.little);
    _offset += 4;
    return value;
  }

  int readUint() {
    assert(_data.length >= _offset + 4);
    var value = ByteData.view(_data.buffer).getUint32(_offset, Endian.little);
    _offset += 4;
    return value;
  }

  double readFixed() {
    var value = readUint();
    var sign = value & 0x80000000 != 0 ? -1 : 1;
    var integer = (value >> 8) & 0x7fffff;
    var fraction = value & 0xff;
    return sign * (integer + fraction / 255.0);
  }

  Uint8List readArray() {
    var length = readUint();
    var paddedLength = length;
    if (paddedLength % 4 != 0) {
      paddedLength += 4 - (paddedLength % 4);
    }
    assert(_data.length >= _offset + paddedLength);

    var value = _data.sublist(_offset, _offset + length);
    _offset += length;

    // Skip padding.
    for (var i = length; i < paddedLength; i++) {
      assert(_data[_offset] == 0x00);
      _offset++;
    }

    return value;
  }

  List<int> readUintArray() {
    var length = readUint();
    var paddedLength = length;
    if (paddedLength % 4 != 0) {
      paddedLength += 4 - (paddedLength % 4);
    }
    assert(_data.length >= _offset + paddedLength);

    assert(length % 4 == 0);
    var value = <int>[];
    for (var o = 0; o < length; o += 4) {
      value.add(readUint());
    }

    // Skip padding.
    for (var i = length; i < paddedLength; i++) {
      assert(_data[_offset] == 0x00);
      _offset++;
    }

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

  int readFd() {
    return -1;
  }
}

class WaylandWriteBuffer {
  final _data = <int>[];
  final _fds = <ResourceHandle>[];

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

  void writeObject(WaylandObject? object) {
    writeUint(object?.id ?? 0);
  }

  void writeFd(ResourceHandle fd) {
    _fds.add(fd);
  }
}

abstract class WaylandObject {
  final WaylandClient client;
  final int id;

  String get interfaceName;

  WaylandObject(this.client, this.id) {
    client._objects[id] = this;
  }

  bool processEvent(int code, Uint8List payload) => false;
}

class WaylandDisplay extends WaylandObject {
  @override
  String get interfaceName => 'wl_display';

  WaylandDisplay(WaylandClient client) : super(client, 1);

  WaylandCallback sync(Function(int) onDone) {
    var callback = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(callback);
    client.sendRequest(id, 0, payload.data);
    return WaylandCallback(client, callback, onDone);
  }

  WaylandRegistry getRegistry(
      {Function(int, String, int)? onGlobal, Function(int)? onGlobalRemove}) {
    var registry = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(registry);
    client.sendRequest(id, 1, payload.data);
    return WaylandRegistry(client, registry,
        onGlobal: onGlobal, onGlobalRemove: onGlobalRemove);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var objectId = buffer.readUint();
        var errorCode = buffer.readUint();
        var message = buffer.readString();
        // Codes: { 0: invalidObject, 1: invalidMethod, 2: noMemory, 3: implementation }
        print('wl_display::error $objectId $errorCode $message');
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var id = buffer.readUint();
        client._objects.remove(id);
        return true;
      default:
        return false;
    }
  }
}

class WaylandRegistry extends WaylandObject {
  @override
  String get interfaceName => 'wl_registry';

  Function(int, String, int)? onGlobal;
  Function(int)? onGlobalRemove;

  WaylandRegistry(WaylandClient client, int id,
      {this.onGlobal, this.onGlobalRemove})
      : super(client, id);

  int bind(int name, String interface, int version) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(name);
    payload.writeString(interface);
    payload.writeUint(version);
    payload.writeUint(id);
    client.sendRequest(this.id, 0, payload.data);
    return id;
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var name = buffer.readUint();
        var interface = buffer.readString();
        var version = buffer.readUint();
        onGlobal?.call(name, interface, version);
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var name = buffer.readUint();
        onGlobalRemove?.call(name);
        return true;
      default:
        return false;
    }
  }
}

class WaylandCallback extends WaylandObject {
  @override
  String get interfaceName => 'wl_callback';

  final Function(int) onDone;

  WaylandCallback(WaylandClient client, int id, this.onDone)
      : super(client, id);

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var callbackData = buffer.readUint();
        onDone(callbackData);
        return true;
      default:
        return false;
    }
  }
}

class WaylandCompositor extends WaylandObject {
  @override
  String get interfaceName => 'wl_compositor';

  WaylandCompositor(WaylandClient client, int id) : super(client, id);

  WaylandSurface createSurface(
      {Function(WaylandOutput)? onEnter, Function(WaylandOutput)? onLeave}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 0, payload.data);
    return WaylandSurface(client, id, onEnter: onEnter, onLeave: onLeave);
  }

  WaylandRegion createRegion() {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 1, payload.data);
    return WaylandRegion(client, id);
  }
}

class WaylandShmPool extends WaylandObject {
  @override
  String get interfaceName => 'wl_shm_pool';

  WaylandShmPool(WaylandClient client, int id) : super(client, id);

  WaylandBuffer createBuffer(
      {int offset = 0,
      required int width,
      required int height,
      required int stride,
      required WaylandShmFormat format,
      Function()? onRelease}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeInt(offset);
    payload.writeInt(width);
    payload.writeInt(height);
    payload.writeInt(stride);
    payload.writeUint(_encodeShmFormat(format));
    client.sendRequest(this.id, 0, payload.data);
    return WaylandBuffer(client, id, onRelease: onRelease);
  }

  void destroy() {
    client.sendRequest(id, 1);
  }

  void resize(int size) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(size);
    client.sendRequest(id, 2, payload.data);
  }
}

class WaylandShm extends WaylandObject {
  @override
  String get interfaceName => 'wl_shm';

  final formats = <WaylandShmFormat>[];

  WaylandShm(WaylandClient client, int id) : super(client, id);

  Future<WaylandShmPool> createPool(int size) async {
    var shmFile = await File('/dev/shm').open();
    var fd = ResourceHandle.fromFile(shmFile);

    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeFd(fd);
    payload.writeUint(size);
    client.sendRequest(this.id, 0, payload.data);
    return WaylandShmPool(client, id);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var format = _decodeShmFormat(buffer.readUint());
        if (format != null) {
          formats.add(format);
        }
        return true;
      default:
        return false;
    }
  }
}

class WaylandBuffer extends WaylandObject {
  @override
  String get interfaceName => 'wl_buffer';

  final Function()? onRelease;

  WaylandBuffer(WaylandClient client, int id, {this.onRelease})
      : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        onRelease?.call();
        return true;
      default:
        return false;
    }
  }
}

class WaylandDataOffer extends WaylandObject {
  @override
  String get interfaceName => 'wl_data_offer';

  WaylandDataOffer(WaylandClient client, int id) : super(client, id);
}

class WaylandDataSource extends WaylandObject {
  @override
  String get interfaceName => 'wl_data_source';

  Function(String?)? onTarget;
  Function(String, int)? onSend;
  Function()? onCancelled;
  Function()? onDndDropPerformed;
  Function()? onDndDropFinished;
  Function(int)? onAction;

  WaylandDataSource(WaylandClient client, int id,
      {this.onTarget,
      this.onSend,
      this.onCancelled,
      this.onDndDropPerformed,
      this.onDndDropFinished,
      this.onAction})
      : super(client, id);

  void offer(String mimeType) {
    var payload = WaylandWriteBuffer();
    payload.writeString(mimeType);
    client.sendRequest(id, 0, payload.data);
  }

  void destroy() {
    client.sendRequest(id, 1);
  }

  void setActions(int actions) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(actions);
    client.sendRequest(id, 2, payload.data);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var mimeType = buffer.readString();
        onTarget?.call(mimeType);
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var mimeType = buffer.readString();
        var fd = buffer.readFd();
        onSend?.call(mimeType, fd);
        return true;
      case 2:
        onCancelled?.call();
        return true;
      case 3:
        onDndDropPerformed?.call();
        return true;
      case 4:
        onDndDropFinished?.call();
        return true;
      case 5:
        var buffer = WaylandReadBuffer(payload);
        var dndAction = buffer.readUint();
        onAction?.call(dndAction);
        return true;
      default:
        return false;
    }
  }
}

class WaylandDataDevice extends WaylandObject {
  @override
  String get interfaceName => 'wl_data_device';

  WaylandDataDevice(WaylandClient client, int id) : super(client, id);

  void startDrag(
      {WaylandDataSource? source,
      required WaylandSurface origin,
      WaylandSurface? icon,
      required int serial}) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(source);
    payload.writeObject(origin);
    payload.writeObject(icon);
    payload.writeUint(serial);
    client.sendRequest(id, 0, payload.data);
  }

  void setSelection({WaylandDataSource? source, required int serial}) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(source);
    payload.writeUint(serial);
    client.sendRequest(id, 1, payload.data);
  }

  void release() {
    client.sendRequest(id, 2);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        print('wl_data_device::dataOffer $payload');
        return true;
      case 1:
        print('wl_data_device::enter $payload');
        return true;
      case 2:
        print('wl_data_device::leave $payload');
        return true;
      case 3:
        print('wl_data_device::motion $payload');
        return true;
      case 4:
        print('wl_data_device::drop $payload');
        return true;
      case 5:
        print('wl_data_device::selection $payload');
        return true;
      default:
        return false;
    }
  }
}

class WaylandDataDeviceManager extends WaylandObject {
  @override
  String get interfaceName => 'wl_data_device_manager';

  WaylandDataDeviceManager(WaylandClient client, int id) : super(client, id);

  WaylandDataSource createDataSource(
      {Function(String?)? onTarget,
      Function(String, int)? onSend,
      Function()? onCancelled,
      Function()? onDndDropPerformed,
      Function()? onDndDropFinished,
      Function(int)? onAction}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 0, payload.data);
    return WaylandDataSource(client, id,
        onTarget: onTarget,
        onSend: onSend,
        onCancelled: onCancelled,
        onDndDropPerformed: onDndDropPerformed,
        onDndDropFinished: onDndDropFinished,
        onAction: onAction);
  }

  WaylandDataDevice getDataDevice(WaylandSeat seat) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeObject(seat);
    client.sendRequest(this.id, 1, payload.data);
    return WaylandDataDevice(client, id);
  }
}

class WaylandSurface extends WaylandObject {
  @override
  String get interfaceName => 'wl_surface';

  final Function(WaylandOutput)? onEnter;
  final Function(WaylandOutput)? onLeave;

  WaylandSurface(WaylandClient client, int id, {this.onEnter, this.onLeave})
      : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  void attach(WaylandBuffer buffer, int x, int y) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(buffer);
    payload.writeInt(x);
    payload.writeInt(y);
    client.sendRequest(id, 1, payload.data);
  }

  void damage(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 2, payload.data);
  }

  WaylandCallback frame(Function(int) onDone) {
    var callback = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(callback);
    client.sendRequest(id, 3, payload.data);
    return WaylandCallback(client, callback, onDone);
  }

  void setOpaqueRegion(WaylandRegion? region) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(region);
    client.sendRequest(id, 4, payload.data);
  }

  void setInputRegion(WaylandRegion? region) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(region);
    client.sendRequest(id, 5, payload.data);
  }

  void commit() {
    client.sendRequest(id, 6);
  }

  void setBufferTransform(int transform) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(transform);
    client.sendRequest(id, 7, payload.data);
  }

  void setBufferScale(int scale) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(scale);
    client.sendRequest(id, 8, payload.data);
  }

  void damageBuffer(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 9, payload.data);
  }

  void offset(int x, int y) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    client.sendRequest(id, 10, payload.data);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var output = client._objects[buffer.readUint()] as WaylandOutput;
        onEnter?.call(output);
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var output = client._objects[buffer.readUint()] as WaylandOutput;
        onLeave?.call(output);
        return true;
      default:
        return false;
    }
  }
}

class WaylandSeat extends WaylandObject {
  @override
  String get interfaceName => 'wl_seat';

  int capabilities = 0;

  /// Name of the seat.
  String name = '';

  WaylandSeat(WaylandClient client, int id) : super(client, id);

  WaylandPointer getPointer(
      {Function(int serial, WaylandSurface surface, double x, double y)?
          onEnter,
      Function(int serial, WaylandSurface surface)? onLeave,
      Function(int time, double x, double y)? onMotion,
      Function(int serial, int time, int button, int state)? onButton}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 0, payload.data);
    return WaylandPointer(client, id,
        onEnter: onEnter,
        onLeave: onLeave,
        onMotion: onMotion,
        onButton: onButton);
  }

  WaylandKeyboard getKeyboard(
      {Function(int serial, WaylandSurface surface, Uint8List keys)? onEnter,
      Function(int serial, WaylandSurface surface)? onLeave,
      Function(int serial, int time, int key, int state)? onKey}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 1, payload.data);
    return WaylandKeyboard(client, id,
        onEnter: onEnter, onLeave: onLeave, onKey: onKey);
  }

  WaylandTouch getTouch() {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 2, payload.data);
    return WaylandTouch(client, id);
  }

  void release() {
    client.sendRequest(id, 3);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        capabilities = buffer.readUint();
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        name = buffer.readString();
        return true;
      default:
        return false;
    }
  }
}

class WaylandPointer extends WaylandObject {
  @override
  String get interfaceName => 'wl_pointer';

  final Function(int serial, WaylandSurface surface, double x, double y)?
      onEnter;
  final Function(int serial, WaylandSurface surface)? onLeave;
  final Function(int time, double x, double y)? onMotion;
  final Function(int serial, int time, int button, int state)? onButton;

  WaylandPointer(WaylandClient client, int id,
      {this.onEnter, this.onLeave, this.onMotion, this.onButton})
      : super(client, id);

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var surface = client._objects[buffer.readUint()] as WaylandSurface;
        var x = buffer.readFixed();
        var y = buffer.readFixed();
        onEnter?.call(serial, surface, x, y);
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var surface = client._objects[buffer.readUint()] as WaylandSurface;
        onLeave?.call(serial, surface);
        return true;
      case 2:
        var buffer = WaylandReadBuffer(payload);
        var time = buffer.readUint();
        var x = buffer.readFixed();
        var y = buffer.readFixed();
        onMotion?.call(time, x, y);
        return true;
      case 3:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var time = buffer.readUint();
        var button = buffer.readUint();
        var state = buffer.readUint();
        onButton?.call(serial, time, button, state);
        return true;
      case 4:
        print('wl_pointer::axis $payload');
        return true;
      case 5:
        print('wl_pointer::frame $payload');
        return true;
      case 6:
        print('wl_pointer::axis_source $payload');
        return true;
      case 7:
        print('wl_pointer::axis_stop $payload');
        return true;
      case 8:
        print('wl_pointer::axis_discrete $payload');
        return true;
      case 9:
        print('wl_pointer::axis_value120 $payload');
        return true;
      default:
        return false;
    }
  }
}

class WaylandKeyboard extends WaylandObject {
  @override
  String get interfaceName => 'wl_keyboard';

  /// The rate of repeating keys in characters per second.
  int rate = -1;

  /// Delay in milliseconds since key down until repeating starts.
  int delay = -1;

  final Function(int serial, WaylandSurface surface, Uint8List keys)? onEnter;
  final Function(int serial, WaylandSurface surface)? onLeave;
  final Function(int serial, int time, int key, int state)? onKey;

  WaylandKeyboard(WaylandClient client, int id,
      {this.onEnter, this.onLeave, this.onKey})
      : super(client, id);

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var format = buffer.readUint();
        var fd = buffer.readFd();
        var size = buffer.readUint();
        print('wl_keyboard::keymap $format $fd $size');
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var surface = client._objects[buffer.readUint()] as WaylandSurface;
        var keys = buffer.readArray();
        onEnter?.call(serial, surface, keys);
        return true;
      case 2:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var surface = client._objects[buffer.readUint()] as WaylandSurface;
        onLeave?.call(serial, surface);
        return true;
      case 3:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var time = buffer.readUint();
        var key = buffer.readUint();
        var state = buffer.readUint();
        onKey?.call(serial, time, key, state);
        return true;
      case 4:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        var modsDepressed = buffer.readUint();
        var modsLatched = buffer.readUint();
        var modsLocked = buffer.readUint();
        var group = buffer.readUint();
        print(
            'wl_keyboard::modifiers $serial $modsDepressed $modsLatched $modsLocked $group');
        return true;
      case 5:
        var buffer = WaylandReadBuffer(payload);
        this.rate = buffer.readInt();
        this.delay = buffer.readInt();
        return true;
      default:
        return false;
    }
  }
}

class WaylandTouch extends WaylandObject {
  @override
  String get interfaceName => 'wl_touch';

  WaylandTouch(WaylandClient client, int id) : super(client, id);

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      default:
        return false;
    }
  }
}

class WaylandOutput extends WaylandObject {
  @override
  String get interfaceName => 'wl_output';

  Function()? onDone;

  String name = '';
  String description = '';
  int scaleFactor = 1;

  int x = -1;
  int y = -1;
  int physicalWidth = -1;
  int physicalHeight = -1;
  int subpixel = -1;
  String make = '';
  String model = '';
  int transform = -1;

  int modeFlags = 0;

  /// Width of the mode in hardware units.
  int width = -1;

  /// Height of the mode in hardware units.
  int height = -1;

  /// Vertical refresh rate in mHz
  int refresh = -1;

  WaylandOutput(WaylandClient client, int id, {this.onDone})
      : super(client, id);

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        x = buffer.readInt();
        y = buffer.readInt();
        physicalWidth = buffer.readInt();
        physicalHeight = buffer.readInt();
        subpixel = buffer.readInt();
        make = buffer.readString();
        model = buffer.readString();
        return true;
      case 1:
        var buffer = WaylandReadBuffer(payload);
        modeFlags = buffer.readUint();
        width = buffer.readInt();
        height = buffer.readInt();
        refresh = buffer.readInt();
        return true;
      case 2:
        onDone?.call();
        return true;
      case 3:
        var buffer = WaylandReadBuffer(payload);
        scaleFactor = buffer.readInt();
        return true;
      case 4:
        var buffer = WaylandReadBuffer(payload);
        name = buffer.readString();
        return true;
      case 5:
        var buffer = WaylandReadBuffer(payload);
        description = buffer.readString();
        return true;
      default:
        return false;
    }
  }
}

class WaylandRegion extends WaylandObject {
  @override
  String get interfaceName => 'wl_region';

  WaylandRegion(WaylandClient client, int id) : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  void add(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 1, payload.data);
  }

  void subtract(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 2, payload.data);
  }
}

class XdgWmBase extends WaylandObject {
  @override
  String get interfaceName => 'xdg_wm_base';

  final Function(int)? onPing;

  XdgWmBase(WaylandClient client, int id, {this.onPing}) : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  XdgPositioner createPositioner() {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 1, payload.data);
    return XdgPositioner(client, id);
  }

  XdgSurface getXdgSurface(WaylandSurface surface,
      {Function(int serial)? onConfigure}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeObject(surface);
    client.sendRequest(this.id, 2, payload.data);
    return XdgSurface(client, id, onConfigure: onConfigure);
  }

  void pong(int serial) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(serial);
    client.sendRequest(id, 3, payload.data);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        onPing?.call(serial);
        return true;
      default:
        return false;
    }
  }
}

enum XdgPositionerAnchor {
  none,
  top,
  bottom,
  left,
  right,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight
}

int _encodeAnchor(XdgPositionerAnchor anchor) {
  return {
        XdgPositionerAnchor.none: 0,
        XdgPositionerAnchor.top: 1,
        XdgPositionerAnchor.bottom: 2,
        XdgPositionerAnchor.left: 3,
        XdgPositionerAnchor.right: 4,
        XdgPositionerAnchor.topLeft: 5,
        XdgPositionerAnchor.bottomLeft: 6,
        XdgPositionerAnchor.topRight: 7,
        XdgPositionerAnchor.bottomRight: 8,
      }[anchor] ??
      -1;
}

enum XdgPositionerGravity {
  none,
  top,
  bottom,
  left,
  right,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight
}

int _encodeGravity(XdgPositionerGravity gravity) {
  return {
        XdgPositionerGravity.none: 0,
        XdgPositionerGravity.top: 1,
        XdgPositionerGravity.bottom: 2,
        XdgPositionerGravity.left: 3,
        XdgPositionerGravity.right: 4,
        XdgPositionerGravity.topLeft: 5,
        XdgPositionerGravity.bottomLeft: 6,
        XdgPositionerGravity.topRight: 7,
        XdgPositionerGravity.bottomRight: 8,
      }[gravity] ??
      -1;
}

class XdgPositioner extends WaylandObject {
  @override
  String get interfaceName => 'xdg_positioner';

  XdgPositioner(WaylandClient client, int id) : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  void setSize(int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 1, payload.data);
  }

  void setAnchorRect(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 2, payload.data);
  }

  void setAnchor(XdgPositionerAnchor anchor) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(_encodeAnchor(anchor));
    client.sendRequest(id, 3, payload.data);
  }

  void setGravity(XdgPositionerGravity gravity) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(_encodeGravity(gravity));
    client.sendRequest(id, 4, payload.data);
  }

  // FIXME setConstraintAdjustment

  void setOffset(int x, int y) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    client.sendRequest(id, 6, payload.data);
  }

  void setReactive() {
    var payload = WaylandWriteBuffer();
    client.sendRequest(id, 7, payload.data);
  }

  void setParentSize(int parentWidth, int parentHeight) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(parentWidth);
    payload.writeInt(parentHeight);
    client.sendRequest(id, 6, payload.data);
  }

  void setParentConfigure(int serial) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(serial);
    client.sendRequest(id, 9, payload.data);
  }
}

class XdgSurface extends WaylandObject {
  @override
  String get interfaceName => 'xdg_surface';

  final Function(int serial)? onConfigure;

  XdgSurface(WaylandClient client, int id, {this.onConfigure})
      : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  XdgToplevel getToplevel(
      {Function(int, int, List<int>)? onConfigure,
      Function()? onClose,
      Function(int, int)? onConfigureBounds}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    client.sendRequest(this.id, 1, payload.data);
    return XdgToplevel(client, id,
        onConfigure: onConfigure,
        onClose: onClose,
        onConfigureBounds: onConfigureBounds);
  }

  XdgPopup getPopup(int parent, XdgPositioner positioner,
      {Function(int, int, int, int)? onConfigure,
      Function()? onPopupDone,
      Function(int)? onRepositioned}) {
    var id = client._getNextId();
    var payload = WaylandWriteBuffer();
    payload.writeUint(id);
    payload.writeUint(parent);
    payload.writeObject(positioner);
    client.sendRequest(this.id, 2, payload.data);
    return XdgPopup(client, id,
        onConfigure: onConfigure,
        onPopupDone: onPopupDone,
        onRepositioned: onRepositioned);
  }

  void setWindowGeometry(int x, int y, int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(x);
    payload.writeInt(y);
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 3, payload.data);
  }

  void ackConfigure(int serial) {
    var payload = WaylandWriteBuffer();
    payload.writeUint(serial);
    client.sendRequest(id, 4, payload.data);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var serial = buffer.readUint();
        onConfigure?.call(serial);
        return true;
      default:
        return false;
    }
  }
}

class XdgToplevel extends WaylandObject {
  @override
  String get interfaceName => 'xdg_toplevel';

  final Function(int, int, List<int>)? onConfigure;
  final Function()? onClose;
  final Function(int, int)? onConfigureBounds;

  XdgToplevel(WaylandClient client, int id,
      {this.onConfigure, this.onClose, this.onConfigureBounds})
      : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  void setParent(XdgToplevel? parent) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(parent);
    client.sendRequest(id, 1, payload.data);
  }

  void setTitle(String title) {
    var payload = WaylandWriteBuffer();
    payload.writeString(title);
    client.sendRequest(id, 2, payload.data);
  }

  void setAppId(String appId) {
    var payload = WaylandWriteBuffer();
    payload.writeString(appId);
    client.sendRequest(id, 3, payload.data);
  }

  void showWindowMenu(WaylandSeat seat, int serial, int x, int y) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(seat);
    payload.writeUint(serial);
    payload.writeInt(x);
    payload.writeInt(y);
    client.sendRequest(id, 4, payload.data);
  }

  void move(WaylandSeat seat, int serial) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(seat);
    payload.writeUint(serial);
    client.sendRequest(id, 5, payload.data);
  }

  void resize(WaylandSeat seat, int serial, int edge) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(seat);
    payload.writeUint(serial);
    payload.writeUint(edge);
    client.sendRequest(id, 6, payload.data);
  }

  void setMaxSize(int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 7, payload.data);
  }

  void setMinSize(int width, int height) {
    var payload = WaylandWriteBuffer();
    payload.writeInt(width);
    payload.writeInt(height);
    client.sendRequest(id, 8, payload.data);
  }

  void setMaximized() {
    client.sendRequest(id, 9);
  }

  void unsetMaximized() {
    client.sendRequest(id, 10);
  }

  void setFullscren({WaylandOutput? output}) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(output);
    client.sendRequest(id, 11, payload.data);
  }

  void unsetFullscren() {
    client.sendRequest(id, 12);
  }

  void setMinimized() {
    client.sendRequest(id, 13);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var width = buffer.readInt();
        var height = buffer.readInt();
        var states = buffer.readUintArray();
        onConfigure?.call(width, height, states);
        return true;
      case 1:
        onClose?.call();
        return true;
      case 2:
        var buffer = WaylandReadBuffer(payload);
        var width = buffer.readInt();
        var height = buffer.readInt();
        onConfigureBounds?.call(width, height);
        return true;
      case 3:
        var buffer = WaylandReadBuffer(payload);
        var capabilities = buffer.readArray();
        print('xdg_toplevel::wmCapabilities $capabilities');
        return true;
      default:
        return false;
    }
  }
}

class XdgPopup extends WaylandObject {
  @override
  String get interfaceName => 'xdg_popup';

  final Function(int, int, int, int)? onConfigure;
  final Function()? onPopupDone;
  final Function(int)? onRepositioned;

  XdgPopup(WaylandClient client, int id,
      {this.onConfigure, this.onPopupDone, this.onRepositioned})
      : super(client, id);

  void destroy() {
    client.sendRequest(id, 0);
  }

  void grab(WaylandSeat seat, int serial) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(seat);
    payload.writeUint(serial);
    client.sendRequest(id, 1, payload.data);
  }

  void reposition(XdgPositioner positioner, int token) {
    var payload = WaylandWriteBuffer();
    payload.writeObject(positioner);
    payload.writeUint(token);
    client.sendRequest(id, 2, payload.data);
  }

  @override
  bool processEvent(int code, Uint8List payload) {
    switch (code) {
      case 0:
        var buffer = WaylandReadBuffer(payload);
        var x = buffer.readInt();
        var y = buffer.readInt();
        var width = buffer.readInt();
        var height = buffer.readInt();
        onConfigure?.call(x, y, width, height);
        return true;
      case 1:
        onPopupDone?.call();
        return true;
      case 2:
        var buffer = WaylandReadBuffer(payload);
        var token = buffer.readUint();
        onRepositioned?.call(token);
        return true;
      default:
        return false;
    }
  }
}
