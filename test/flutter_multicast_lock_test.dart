import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_multicast_lock/flutter_multicast_lock.dart';
import 'package:flutter_multicast_lock/flutter_multicast_lock_platform_interface.dart';
import 'package:flutter_multicast_lock/flutter_multicast_lock_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMulticastLockPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMulticastLockPlatform {
  bool _isLockHeld = false;

  @override
  Future<void> acquireMulticastLock({String? lockName}) async {
    _isLockHeld = true;
  }

  @override
  void setExceptionOnUnsupportedPlatform(bool value) {}

  @override
  bool get exceptionOnUnsupportedPlatform => false;

  @override
  Future<void> releaseMulticastLock() async {
    _isLockHeld = false;
  }

  @override
  Future<bool> isMulticastLockHeld() async {
    return _isLockHeld;
  }
}

void main() {
  final FlutterMulticastLockPlatform initialPlatform =
      FlutterMulticastLockPlatform.instance;

  test('$MethodChannelFlutterMulticastLock is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMulticastLock>());
  });

  test('multicast lock operations', () async {
    FlutterMulticastLock flutterMulticastLockPlugin = FlutterMulticastLock();
    MockFlutterMulticastLockPlatform fakePlatform =
        MockFlutterMulticastLockPlatform();
    FlutterMulticastLockPlatform.instance = fakePlatform;

    // Initially not held
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), false);

    // Acquire lock without lockName
    await flutterMulticastLockPlugin.acquireMulticastLock();
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), true);

    // Release lock
    await flutterMulticastLockPlugin.releaseMulticastLock();
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), false);
  });

  test('multicast lock operations with custom lockName', () async {
    FlutterMulticastLock flutterMulticastLockPlugin = FlutterMulticastLock();
    MockFlutterMulticastLockPlatform fakePlatform =
        MockFlutterMulticastLockPlatform();
    FlutterMulticastLockPlatform.instance = fakePlatform;

    // Initially not held
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), false);

    // Acquire lock with custom lockName
    await flutterMulticastLockPlugin.acquireMulticastLock(
      lockName: 'custom_lock_name',
    );
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), true);

    // Release lock
    await flutterMulticastLockPlugin.releaseMulticastLock();
    expect(await flutterMulticastLockPlugin.isMulticastLockHeld(), false);
  });

  test(
    'when using exceptionOnUnsupportedPlatform, exceptions should be thrown',
    () {
      FlutterMulticastLockPlatform.instance = initialPlatform;

      FlutterMulticastLock flutterMulticastLockPlugin = FlutterMulticastLock();
      flutterMulticastLockPlugin.exceptionOnUnsupportedPlatform = true;

      expect(
        () async => flutterMulticastLockPlugin.acquireMulticastLock(),
        throwsA(isA<PlatformException>()),
      );

      expect(
        () async => flutterMulticastLockPlugin.releaseMulticastLock(),
        throwsA(isA<PlatformException>()),
      );

      expect(
        () async => flutterMulticastLockPlugin.isMulticastLockHeld(),
        throwsA(isA<PlatformException>()),
      );
    },
  );
}
