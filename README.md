# flutter_ringtone_player

A simple ringtone, alarm & notification player plugin.

[![pub package](https://img.shields.io/pub/v/flutter_ringtone_player.svg)](https://pub.dartlang.org/packages/flutter_ringtone_player)

## Usage

Add following import to your code:

```dart
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
```

Then simply call this to play system default notification sound:

```dart
FlutterRingtonePlayer.playNotification();
```

You can also specify some additional parameters (works only on Android with API 28 and above):

```dart
FlutterRingtonePlayer.playNotification(volume: 0.5, looping: true);
```

There's also this generic method allowing you to specify in detail what kind of ringtone should be played:

```dart
FlutterRingtonePlayer.play(
  android: AndroidSounds.notification,
  ios: IosSounds.glass,
  looping: true,
  volume: 0.1,
);

```

To stop looped ringtone please use:

```dart
FlutterRingtonePlayer.stop();
```

Above works only on Android, and please note that by default Alarm & Ringtone sounds are looped.

## Default sounds

| Method           | Android | iOS |
| ---------------- | ------- | --- |
| playAlarm        | [System#DEFAULT_ALARM_ALERT_URI](https://developer.android.com/reference/android/provider/Settings.System.html#DEFAULT_ALARM_ALERT_URI) | IosSounds.horn |
| playNotification | [System#DEFAULT_NOTIFICATION_URI](https://developer.android.com/reference/android/provider/Settings.System.html#DEFAULT_NOTIFICATION_URI) | IosSounds.triTone |
| playRingtone     | [System#DEFAULT_RINGTONE_URI](https://developer.android.com/reference/android/provider/Settings.System.html#DEFAULT_RINGTONE_URI) | IosSounds.electronic |

### Note on iOS sounds

If you want to use any other sound on iOS you can always specify a valid Sound ID and manually construct [IosSound]:

```dart
FlutterRingtonePlayer.play(
  android: AndroidSounds.notification,
  ios: const IosSound(1023),
  looping: true,
  volume: 0.1,
);
```
