import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_multicast_lock_platform_interface.dart';

/// An implementation of [FlutterMulticastLockPlatform] that uses method channels.
class MethodChannelFlutterMulticastLock extends FlutterMulticastLockPlatform {
  bool _exceptionOnUnsupportedPlatform = false;

  /// Indicates whether an exception should be thrown on unsupported platforms.
  /// If set to true, an exception will be thrown when trying to use the
  /// multicast lock on a platform that does not support it (e.g., non-Android).
  @override
  bool get exceptionOnUnsupportedPlatform => _exceptionOnUnsupportedPlatform;

  @override
  /// Sets whether an exception should be thrown on unsupported platforms.
  void setExceptionOnUnsupportedPlatform(bool value) {
    _exceptionOnUnsupportedPlatform = value;
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel? methodChannel = Platform.isAndroid
      ? const MethodChannel('com.zeyus.flutter_multicast_lock/manage')
      : null;

  bool _checkPlatform() {
    if (exceptionOnUnsupportedPlatform && methodChannel == null) {
      throw PlatformException(
        code: 'UNSUPPORTED_PLATFORM',
        message:
            'Android multicast lock is only supported on Android platforms',
        details: 'Current platform: ${Platform.operatingSystem}',
      );
    }
    return methodChannel != null;
  }

  @override
  Future<void> acquireMulticastLock({String? lockName}) async {
    if (!_checkPlatform()) {
      return;
    }
    await methodChannel!.invokeMethod<void>('acquireMulticastLock', {
      if (lockName != null) 'lockName': lockName,
    });
  }

  @override
  Future<void> releaseMulticastLock() async {
    if (!_checkPlatform()) {
      return;
    }
    await methodChannel!.invokeMethod<void>('releaseMulticastLock');
  }

  @override
  Future<bool> isMulticastLockHeld() async {
    if (!_checkPlatform()) {
      return false;
    }
    final result = await methodChannel!.invokeMethod<bool>(
      'isMulticastLockHeld',
    );
    return result ?? false;
  }
}
