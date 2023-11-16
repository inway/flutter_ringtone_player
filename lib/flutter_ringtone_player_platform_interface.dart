import 'package:flutter_ringtone_player/android_sounds.dart';
import 'package:flutter_ringtone_player/ios_sounds.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ringtone_player_method_channel.dart';

abstract class FlutterRingtonePlayerPlatform extends PlatformInterface {
  /// Constructs a FlutterRingtonePlayerPlatform.
  FlutterRingtonePlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRingtonePlayerPlatform _instance =
      MethodChannelFlutterRingtonePlayer();

  /// The default instance of [FlutterRingtonePlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterRingtonePlayer].
  static FlutterRingtonePlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterRingtonePlayerPlatform] when
  /// they register themselves.
  static set instance(FlutterRingtonePlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> play({
    AndroidSound? android,
    IosSound? ios,
    String? fromAsset,
    double? volume,
    bool? looping,
    bool? asAlarm,
  }) {
    throw UnimplementedError('play() has not been implemented.');
  }

  /// Play default alarm sound (looping on Android)
  Future<void> playAlarm({
    double? volume,
    bool looping = true,
    bool asAlarm = true,
  }) {
    throw UnimplementedError('playAlarm() has not been implemented.');
  }

  /// Play default notification sound
  Future<void> playNotification({
    double? volume,
    bool? looping,
    bool asAlarm = false,
  }) {
    throw UnimplementedError('playNotification() has not been implemented.');
  }

  /// Play default system ringtone (looping on Android)
  Future<void> playRingtone({
    double? volume,
    bool looping = true,
    bool asAlarm = false,
  }) {
    throw UnimplementedError('playRingtone() has not been implemented.');
  }

  /// Stop looping sounds like alarms & ringtones on Android.
  /// This is no-op on iOS.
  Future<void> stop() {
    throw UnimplementedError('stop() has not been implemented.');
  }
}
