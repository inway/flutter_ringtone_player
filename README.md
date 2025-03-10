# flutter_ringtone_player

A simple ringtone, alarm & notification player plugin.

[![pub package](https://img.shields.io/pub/v/flutter_ringtone_player.svg)](https://pub.dartlang.org/packages/flutter_ringtone_player)
[![flutter](https://github.com/inway/flutter_ringtone_player/actions/workflows/flutter.yml/badge.svg)](https://github.com/inway/flutter_ringtone_player/actions/workflows/flutter.yml)

## Usage

Add following import to your code:

```dart
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
```

Then simply call this to play system default notification sound:

```dart
FlutterRingtonePlayer().playNotification();
```

There's also this generic method allowing you to specify in detail what kind of ringtone should be played:

```dart
var _soundId= await FlutterRingtonePlayer().play(
  android: AndroidSounds.notification,
  ios: IosSounds.glass,
  repeatTime: 5, // Ios only 
  looping: true, // Android only - API >= 28
  volume: 0.1, // Android only - API >= 28
  asAlarm: false, // Android only - all APIs
);
```

Also you can specify a custom ringtone from assets, or provide direct path to file that works for 
both Android and iOS:

```dart
var _soundId= await FlutterRingtonePlayer().play(fromAsset: "assets/ringtone.wav");  
```

```dart
var _soundId= await FlutterRingtonePlayer().play(fromFile: "assets/ringtone.wav");  
```

You can specify a platform specific ringtone and it will override the one from assets:
```dart
var _soundId= await FlutterRingtonePlayer().play(  
 fromAsset: "assets/ringtone.wav", // will be the sound on Android
 ios: IosSounds.glass 			   // will be the sound on iOS
 );  
```

### .play() optional attributes

| Attribute         | Description                                                                              |
|-------------------|------------------------------------------------------------------------------------------|
| `bool` looping    | Enables looping of ringtone. Requires `FlutterRingtonePlayer().stop();` to stop ringing. |
| `double` volume   | Sets ringtone volume in range 0 to 1.0.                                                  |
| `int` repeatTime  | Sets ringtone loops on IOS                                                               |
| `bool` asAlarm    | Allows to ignore device's silent/vibration mode and play given sound anyway.             |


To stop looped ringtone please use:

```dart
//pass soundId only for Ios
FlutterRingtonePlayer().stop(soundId: _soundId);
```

Please note that by default Alarm & Ringtone sounds are looped.

## Default sounds

| Method           | Android | iOS |
| ---------------- | ------- | --- |
| playAlarm        | [RingtoneManager.TYPE_ALARM](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_ALARM) | IosSounds.alarm |
| playNotification | [RingtoneManager.TYPE_NOTIFICATION](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_NOTIFICATION) | IosSounds.triTone |
| playRingtone     | [RingtoneManager.TYPE_RINGTONE](https://developer.android.com/reference/android/media/RingtoneManager#TYPE_RINGTONE) | IosSounds.electronic |

### Note on iOS sounds

If you want to use any other sound on iOS you can always specify a valid Sound ID and manually construct [IosSound]:

```dart
var _soundId= await FlutterRingtonePlayer().play(
  android: AndroidSounds.notification,
  ios: const IosSound(1023),
  looping: true,
  volume: 0.1,
);
```
