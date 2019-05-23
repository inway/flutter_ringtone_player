// Copyright 2019 InWay.pro Open Source code. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';

/// Simple player for system sounds like ringtones, alarms and notifications.
class FlutterRingtonePlayer {
  /// Channel used to communicate to native code.
  static const MethodChannel _channel =
      const MethodChannel('flutter_ringtone_player');

  /// This is generic method called by specific ones
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

  /// Play default system ringtone (looping on Android)
  static Future<void> playRingtone({double volume, bool looping}) async =>
      _play('playRingtone', volume: volume, looping: looping);

  /// Play default notification sound
  static Future<void> playNotification({double volume, bool looping}) async =>
      _play('playNotification', volume: volume, looping: looping);

  /// Play default alarm sound (looping on Android)
  static Future<void> playAlarm({double volume, bool looping}) async =>
      _play('playAlarm', volume: volume, looping: looping);

  /// Stop looping sounds like alarms & ringtones on Android.
  /// This is no-op on iOS.
  static Future<void> stop() async {
    try {
      _channel.invokeMethod('stop');
    } on PlatformException {}
  }
}
