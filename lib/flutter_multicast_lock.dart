import 'flutter_multicast_lock_platform_interface.dart';

class FlutterMulticastLock {
  bool _exceptionOnUnsupportedPlatform = false;
  bool get exceptionOnUnsupportedPlatform => _exceptionOnUnsupportedPlatform;
  set exceptionOnUnsupportedPlatform(bool value) {
    _exceptionOnUnsupportedPlatform = value;
    FlutterMulticastLockPlatform.instance.setExceptionOnUnsupportedPlatform(
      value,
    );
  }

  Future<void> acquireMulticastLock({String? lockName}) {
    return FlutterMulticastLockPlatform.instance.acquireMulticastLock(
      lockName: lockName,
    );
  }

  Future<void> releaseMulticastLock() {
    return FlutterMulticastLockPlatform.instance.releaseMulticastLock();
  }

  Future<bool> isMulticastLockHeld() {
    return FlutterMulticastLockPlatform.instance.isMulticastLockHeld();
  }
}
