import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRingtonePlayer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ringtone_player');

  static Future<void> _play(
    String method, {
    double volume,
    bool looping,
  }) async {
    try {
      var args = <String, dynamic>{};
      if (volume != null) args['volume'] = volume;
      if (looping != null) args['looping'] = looping;

      _channel.invokeMethod(method, args);
    } on PlatformException {}
  }

  static Future<void> playRingtone({double volume, bool looping}) async =>
      _play('playRingtone', volume: volume, looping: looping);

  static Future<void> playNotification({double volume, bool looping}) async =>
      _play('playNotification', volume: volume, looping: looping);

  static Future<void> playAlarm({double volume, bool looping}) async =>
      _play('playAlarm', volume: volume, looping: looping);

  static Future<void> stop() async {
    try {
      _channel.invokeMethod('stop');
    } on PlatformException {}
  }
}
