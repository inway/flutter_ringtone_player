// Copyright 2019 InWay.pro Open Source code. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_ringtone_player/flutter_ringtone_player_platform_interface.dart';

import 'android_sounds.dart';
import 'ios_sounds.dart';

export 'android_sounds.dart';
export 'ios_sounds.dart';

/// Simple player for system sounds like ringtones, alarms and notifications.
///
/// On Android it uses system default sounds for each ringtone type. On iOS it
/// uses some hardcoded values for each type.
class FlutterRingtonePlayer {
 static Future<dynamic> play({
    AndroidSound? android,
    IosSound? ios,
    String? fromAsset,
    String? fromFile,
    double? volume,
    bool? looping,
    int? repeatTime,
    bool? asAlarm,
  }) {
    return FlutterRingtonePlayerPlatform.instance.play(
      ios: ios,
      volume: volume,
      looping: looping,
      asAlarm: asAlarm,
      repeatTime: repeatTime,
      android: android,
      fromAsset: fromAsset,
      fromFile: fromFile,
    );
  }

  /// Play default alarm sound (looping on Android)
 static  Future<void> playAlarm({
    double? volume,
    bool looping = true,
    bool asAlarm = true,
  }) {
    return FlutterRingtonePlayerPlatform.instance
        .playAlarm(volume: volume, looping: looping, asAlarm: asAlarm);
  }

  /// Play default notification sound
 static Future<void> playNotification({
    double? volume,
    bool? looping,
    bool asAlarm = false,
  }) {
    return FlutterRingtonePlayerPlatform.instance
        .playNotification(volume: volume, looping: looping, asAlarm: asAlarm);
  }

  /// Play default system ringtone (looping on Android)
 static Future<void> playRingtone({
    double? volume,
    bool looping = true,
    bool asAlarm = false,
  }) {
    return FlutterRingtonePlayerPlatform.instance
        .playRingtone(volume: volume, looping: looping, asAlarm: asAlarm);
  }

  /// Stop looping sounds like alarms & ringtones on Android.
  /// This is no-op on iOS.
 static Future<void> stop({String? soundId}) {
    return FlutterRingtonePlayerPlatform.instance.stop(soundId);
  }
}
