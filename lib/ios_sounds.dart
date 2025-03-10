// Copyright 2019 InWay.pro Open Source code. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

/// iOS sound definition.
///
/// Valid values are integers ranging 1000-2000 inclusive.
///
/// See also:
///
///  * http://iphonedevwiki.net/index.php/AudioServices
///  * https://github.com/TUNER88/iOSSystemSoundsLibrary
class IosSound {
  final int value;

  const IosSound(int value)
      : assert(value >= 1000),
        assert(value <= 2000),
        value = value;
}

/// Common values for [IosSound] as specified by file name.
///
/// If you don't find desired sound here, you can always create it
/// by hand using values found in sources mentioned in [IosSound].
///
/// ```dart
/// const IosSound(1023);
/// ```
class IosSounds {
  IosSounds._();

  /// ![](new-mail.caf)
  static const IosSound newMail = IosSound(1000);

  /// ![](mail-sent.caf	)
  static const IosSound mailSent = IosSound(1001);

  /// ![](Voicemail.caf	)
  static const IosSound voicemail = IosSound(1002);

  /// ![](ReceivedMessage.caf)
  static const IosSound receivedMessage = IosSound(1003);

  /// ![](SentMessage.caf)
  static const IosSound sentMessage = IosSound(1004);

  /// ![](alarm.caf)
  static const IosSound alarm = IosSound(1005);

  /// ![](low_power.caf	)
  static const IosSound lowPower = IosSound(1006);

  /// ![](SentMessage.caf)
  static const IosSound triTone = IosSound(1007);

  /// ![](sms-received2.caf)
  static const IosSound chime = IosSound(1008);

  /// ![](sms-received3.caf)
  static const IosSound glass = IosSound(1009);

  /// ![](sms-received4.caf)
  static const IosSound horn = IosSound(1010);

  /// ![](sms-received5.caf)
  static const IosSound bell = IosSound(1013);

  /// ![](sms-received6.caf)
  static const IosSound electronic = IosSound(1014);
}
