# flutter_multicast_lock

![Pub Publisher](https://img.shields.io/pub/publisher/flutter_multicast_lock?style=flat-square) ![Pub Version](https://img.shields.io/pub/v/flutter_multicast_lock)

A Flutter plugin for managing Android WiFi multicast locks. This plugin allows you to acquire and release multicast locks on Android devices, which is necessary for receiving multicast UDP packets.

## Features

- ✅ Acquire WiFi multicast locks on Android
- ✅ Release WiFi multicast locks on Android  
- ✅ Check if multicast lock is currently held
- ✅ Cross-platform compatible (no-op on iOS/other platforms, with option to throw exceptions)
- ✅ Automatic permission handling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_multicast_lock: ^1.1.1
```

## Android Setup

The plugin automatically includes the required Android permission. No additional setup is needed.

However, if you want to explicitly declare the permission in your app's `android/app/src/main/AndroidManifest.xml`, add:

```xml
<uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
```

## Usage

```dart
import 'package:flutter_multicast_lock/flutter_multicast_lock.dart';

final flutterMulticastLock = FlutterMulticastLock();

// Acquire the multicast lock
await flutterMulticastLock.acquireMulticastLock();

// Check if lock is held
bool isHeld = await flutterMulticastLock.isMulticastLockHeld();
print('Multicast lock held: $isHeld');

// Release the multicast lock
await flutterMulticastLock.releaseMulticastLock();
```

## API Reference

### `exceptionOnUnsupportedPlatform`

A boolean flag that determines whether to throw an exception when the plugin is used on unsupported platforms (iOS, Web, Windows, macOS, Linux).
Defaults to `false`, meaning it will complete successfully but do nothing on unsupported platforms. Set to `true` to throw a `PlatformException` instead.

### `acquireMulticastLock()`

Acquires the WiFi multicast lock. This allows the device to receive multicast UDP packets.

**Returns:** `Future<void>`

**Throws:** `PlatformException` if the lock cannot be acquired.

### `releaseMulticastLock()`

Releases the WiFi multicast lock.

**Returns:** `Future<void>`

**Throws:** `PlatformException` if the lock cannot be released.

### `isMulticastLockHeld()`

Checks whether the multicast lock is currently held.

**Returns:** `Future<bool>` - `true` if the lock is held, `false` otherwise.

## Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅        |
| iOS      | ❌ (no-op or exception) |
| Web      | ❌ (no-op or exception) |
| Windows  | ❌ (no-op or exception) |
| macOS    | ❌ (no-op or exception) |
| Linux    | ❌ (no-op or exception) |

On non-Android platforms, all methods complete successfully but perform no operations.

## Why Use Multicast Locks?

Android devices normally filter out multicast packets to save battery. When your app needs to receive multicast UDP packets (common in networking protocols, device discovery, etc.), you must acquire a multicast lock to ensure these packets are delivered to your app.

## Example

See the [`example`](example/lib/main.dart) for a complete Flutter app demonstrating how to use this plugin.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
