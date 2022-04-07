// Copyright 2019 InWay.pro Open Source code. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

/// Android sound kind.
///
/// Valid values are 1-3, as specified in [AndroidSounds].
///
/// See also:
///
///  * [AndroidSounds]
class AndroidSound {
  final int value;

  const AndroidSound(this.value)
      : assert(value >= 1),
        assert(value <= 3);
}

/// Default [AndroidSound] values.
class AndroidSounds {
  AndroidSounds._();

  /// System default alarm sound
  static const AndroidSound alarm = AndroidSound(1);

  /// System default notification sound
  static const AndroidSound notification = AndroidSound(2);

  /// System default ringtone sound
  static const AndroidSound ringtone = AndroidSound(3);
}
