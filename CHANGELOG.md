## 5.0.0-dev.1

- **BREAKING CHANGE** [#77](https://github.com/inway/flutter_ringtone_player/pull/77): fix of deprecated API usage by @rockerer

## 4.0.0+4

- Removes references to Flutter v1 android embedding classes.

## 4.0.0+3

- Moved `flutter_lints` to `dev_dependencies` to resolve [#80](https://github.com/inway/flutter_ringtone_player/issues/80)
- Update `compileSdkVersion` of example app by @rockerer [#78](https://github.com/inway/flutter_ringtone_player/pull/78)
- Bump `flutter_lints` from 3.0.2 to 4.0.0 by @dependabot [#79](https://github.com/inway/flutter_ringtone_player/pull/79)

## 4.0.0+2

- Update README to match v4

## 4.0.0+1

- Bump `plugin_platform_interface` version

## 4.0.0

- **BREAKING CHANGE** [#64](https://github.com/inway/flutter_ringtone_player/pull/64): support for Flutter 3.0 and Android Gradle plugin 8.1.3 - @bitsydarel
- [#63](https://github.com/inway/flutter_ringtone_player/pull/63): add support for playing ringtones from direct path - @EngALAlfy

## 3.2.0

Thanks to @GeorgeAmgad added:

- Custom ringtones from assets for Android and iOS. #33

## 3.1.1

- Fix FileNotFoundException but notification is played #4 #29
- Update docs to match changes from #29

## 3.1.0

- Android V2 embedding (thanks to @aarajput)
- Added `test` package to `dev_dependencies` to fix CI errors

## 3.0.0

Thanks to @andzejsw added:

- Flutter 2.0 support
- Null safety (breaking change)
- androidx

## 2.0.0

Breaking changes:

- Add supported platforms to `pubspec.yaml` and in result require flutter version >=1.10
- Allow playing sounds as alarms (thanks to @wrbl606)

## 1.0.3

- Fix iOS issues

## 1.0.2

- Organize return & results logic to fix #1

## 1.0.1

- Refactor API to allow arbitrary sound ID's on iOS

## 1.0.0

- Stable version with iOS & Android support

## 0.0.1

- Initial release.
