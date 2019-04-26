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

## Methods

| Method           | Android | iOS |
| ---------------- | ------- | --- |
| playAlarm        | RingtoneManager.TYPE_ALARM | Plays MailReceived sound (new-mail.caf) |
| playNotification | RingtoneManager.TYPE_NOTIFICATION | Plays MailReceived sound (new-mail.caf) |
| playRingtone     | RingtoneManager.TYPE_RINGTONE | Plays MailReceived sound (new-mail.caf) |
| stop             | Stop looped sounds | No-op |

### Note on iOS sounds

On iOS you have to manualy choose sounds to be played. Current plugin defaults are shown above. 
To change them edit `ios/Classes/FlutterRingtonePlayerPlugin.m` and replace value for `AudioServicesPlaySystemSound()`.

You can find valid values here:
* http://iphonedevwiki.net/index.php/AudioServices
* https://github.com/TUNER88/iOSSystemSoundsLibrary
