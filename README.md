# flutter_ringtone_player_advanced

A simple ringtone, alarm & notification player plugin.

[![pub package](https://img.shields.io/pub/v/flutter_ringtone_player_advanced.svg)](https://pub.dev/packages/flutter_ringtone_player_advanced)
[![flutter](https://github.com/nafiskabbo/flutter_ringtone_player_advanced/actions/workflows/flutter.yml/badge.svg)](https://github.com/nafiskabbo/flutter_ringtone_player_advanced/actions/workflows/flutter.yml)

Community-maintained fork of [inway/flutter_ringtone_player](https://github.com/inway/flutter_ringtone_player), republished as **`flutter_ringtone_player_advanced`** on [pub.dev](https://pub.dev/packages/flutter_ringtone_player_advanced). Maintained by [Nafis Kabbo](https://github.com/nafiskabbo). Issues and pull requests are welcome at [nafiskabbo/flutter_ringtone_player_advanced](https://github.com/nafiskabbo/flutter_ringtone_player_advanced).

## Installation

```yaml
dependencies:
  flutter_ringtone_player_advanced: ^5.0.0
```

## Migrating from `flutter_ringtone_player`

Replace the dependency name; Dart APIs stay the same. Only the import URI changes with the package name.

```yaml
dependencies:
  flutter_ringtone_player_advanced: ^5.0.0
```

```dart
import 'package:flutter_ringtone_player_advanced/flutter_ringtone_player_advanced.dart';
```

## Usage

Add following import to your code:

```dart
import 'package:flutter_ringtone_player_advanced/flutter_ringtone_player_advanced.dart';
```

Then simply call this to play system default notification sound:

```dart
FlutterRingtonePlayer().playNotification();
```

There's also this generic method allowing you to specify in detail what kind of ringtone should be played:

```dart
FlutterRingtonePlayer().play(
  android: AndroidSounds.notification,
  ios: IosSounds.glass,
  looping: true, // Android only - API >= 28
  volume: 0.1, // Android only - API >= 28
  asAlarm: false, // Android only - all APIs
);
```

Also you can specify a custom ringtone from assets, or provide direct path to file that works for 
both Android and iOS:

```dart
FlutterRingtonePlayer().play(fromAsset: "assets/ringtone.wav");  
```

```dart
FlutterRingtonePlayer().play(fromFile: "assets/ringtone.wav");  
```

You can specify a platform specific ringtone and it will override the one from assets:
```dart
FlutterRingtonePlayer().play(  
 fromAsset: "assets/ringtone.wav", // will be the sound on Android
 ios: IosSounds.glass 			   // will be the sound on iOS
 );  
```

### .play() optional attributes

| Attribute       |  Description |
| --------------  | ------------ |
| `bool` looping  | Enables looping of ringtone. Requires `FlutterRingtonePlayer().stop();` to stop ringing. |
| `double` volume | Sets ringtone volume in range 0 to 1.0. |
| `bool` asAlarm  | Allows to ignore device's silent/vibration mode and play given sound anyway. |


To stop looped ringtone please use:

```dart
FlutterRingtonePlayer().stop();
```

Above works only on Android, and please note that by default Alarm & Ringtone sounds are looped.

## Default sounds

| Method           | Android | iOS |
| ---------------- | ------- | --- |
| playAlarm        | [RingtoneManager.TYPE_ALARM](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_ALARM) | IosSounds.alarm |
| playNotification | [RingtoneManager.TYPE_NOTIFICATION](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_NOTIFICATION) | IosSounds.triTone |
| playRingtone     | [RingtoneManager.TYPE_RINGTONE](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_RINGTONE) | IosSounds.electronic |

### Note on iOS sounds

If you want to use any other sound on iOS you can always specify a valid Sound ID and manually construct [IosSound]:

```dart
FlutterRingtonePlayer().play(
  android: AndroidSounds.notification,
  ios: const IosSound(1023),
  looping: true,
  volume: 0.1,
);
```
