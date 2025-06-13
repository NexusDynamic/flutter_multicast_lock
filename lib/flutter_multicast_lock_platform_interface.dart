import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_multicast_lock_method_channel.dart';

abstract class FlutterMulticastLockPlatform extends PlatformInterface {
  /// Constructs a FlutterMulticastLockPlatform.
  FlutterMulticastLockPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMulticastLockPlatform _instance =
      MethodChannelFlutterMulticastLock();

  /// The default instance of [FlutterMulticastLockPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMulticastLock].
  static FlutterMulticastLockPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMulticastLockPlatform] when
  /// they register themselves.
  static set instance(FlutterMulticastLockPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    instance.setExceptionOnUnsupportedPlatform(
      _instance.exceptionOnUnsupportedPlatform,
    );
    _instance = instance;
  }

  bool get exceptionOnUnsupportedPlatform;

  void setExceptionOnUnsupportedPlatform(bool value) {
    throw UnimplementedError(
      'setExceptionOnUnsupportedPlatform() has not been implemented.',
    );
  }

  Future<void> acquireMulticastLock({String? lockName}) {
    throw UnimplementedError(
      'acquireMulticastLock() has not been implemented.',
    );
  }

  Future<void> releaseMulticastLock() {
    throw UnimplementedError(
      'releaseMulticastLock() has not been implemented.',
    );
  }

  Future<bool> isMulticastLockHeld() {
    throw UnimplementedError('isMulticastLockHeld() has not been implemented.');
  }
}
