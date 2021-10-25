import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channelName = 'flutter_ringtone_player';

  test('play', () async {
    _initializeFakeRingtoneChannel(channelName, 'play');
    await FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.alarm,
    );
  });
  test('playAlarm', () async {
    _initializeFakeRingtoneChannel(channelName, 'play');
    await FlutterRingtonePlayer.playAlarm();
  });
  test('playNotification', () async {
    _initializeFakeRingtoneChannel(channelName, 'play');
    await FlutterRingtonePlayer.playNotification();
  });
  test('playRingtone', () async {
    _initializeFakeRingtoneChannel(channelName, 'play');
    await FlutterRingtonePlayer.playRingtone();
  });

  test('stop', () async {
    _initializeFakeRingtoneChannel(channelName, 'stop');

    await FlutterRingtonePlayer.stop();
  });
}

void _initializeFakeRingtoneChannel(String channelName, String expectedMethod) {
  const standardMethod = StandardMethodCodec();

  TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
      .setMockMessageHandler(channelName, (ByteData? message) async {
    final methodCall = standardMethod.decodeMethodCall(message);
    if (methodCall.method == expectedMethod) {
      return standardMethod.encodeSuccessEnvelope(null);
    } else {
      fail("Expected '$expectedMethod' method to be called");
    }
  });
}
