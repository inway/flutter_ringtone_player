#import "FlutterRingtonePlayerPlugin.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation FlutterRingtonePlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_ringtone_player"
                                     binaryMessenger:[registrar messenger]];
    FlutterRingtonePlayerPlugin* instance = [[FlutterRingtonePlayerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"playAlarm" isEqualToString:call.method]) {
        AudioServicesPlaySystemSound(1000);
        result(nil);
    } else if ([@"playNotification" isEqualToString:call.method]) {
        AudioServicesPlaySystemSound(1000);
        result(nil);
    } else if ([@"playRingtone" isEqualToString:call.method]) {
        AudioServicesPlaySystemSound(1000);
        result(nil);
    } else if ([@"stop" isEqualToString:call.method]) {
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
