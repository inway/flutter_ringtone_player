// Copyright 2019 InWay.pro Open Source code. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';

import 'android_sounds.dart';
import 'ios_sounds.dart';

export 'android_sounds.dart';
export 'ios_sounds.dart';

/// Simple player for system sounds like ringtones, alarms and notifications.
///
/// On Android it uses system default sounds for each ringtone type. On iOS it
/// uses some hardcoded values for each type.
class FlutterRingtonePlayer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ringtone_player');

  /// This is generic method allowing you to specify individual sounds
  /// you wish to be played for each platform
  ///
  /// [asAlarm] is an Android only flag that lets play given sound
  /// as an alarm, that is, phone will make sound even if
  /// it is in silent or vibration mode.
  ///
  /// See also:
  ///  * [AndroidSounds]
  ///  * [IosSounds]
  static Future<void> play(
      {required AndroidSound android,
      required IosSound ios,
      double? volume,
      bool? looping,
      bool? asAlarm}) async {
    try {
      var args = <String, dynamic>{
        'android': android.value,
        'ios': ios.value,
      };
      if (looping != null) args['looping'] = looping;
      if (volume != null) args['volume'] = volume;
      if (asAlarm != null) args['asAlarm'] = asAlarm;

      _channel.invokeMethod('play', args);
    } on PlatformException {}
  }

  /// Play default alarm sound (looping on Android)
  static Future<void> playAlarm(
          {double? volume, bool looping = true, bool asAlarm = true}) async =>
      play(
          android: AndroidSounds.alarm,
          ios: IosSounds.alarm,
          volume: volume,
          looping: looping,
          asAlarm: asAlarm);

  /// Play default notification sound
  static Future<void> playNotification(
          {double? volume, bool? looping, bool asAlarm = false}) async =>
      play(
          android: AndroidSounds.notification,
          ios: IosSounds.triTone,
          volume: volume,
          looping: looping,
          asAlarm: asAlarm);

  /// Play default system ringtone (looping on Android)
  static Future<void> playRingtone(
          {double? volume, bool looping = true, bool asAlarm = false}) async =>
      play(
          android: AndroidSounds.ringtone,
          ios: IosSounds.electronic,
          volume: volume,
          looping: looping,
          asAlarm: asAlarm);

  /// Stop looping sounds like alarms & ringtones on Android.
  /// This is no-op on iOS.
  static Future<void> stop() async {
    try {
      _channel.invokeMethod('stop');
    } on PlatformException {}
  }
}
