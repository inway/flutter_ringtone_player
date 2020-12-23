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
    if ([@"play" isEqualToString:call.method]) {
        NSNumber *soundId = (NSNumber *)call.arguments[@"ios"];
        AudioServicesPlaySystemSound([soundId integerValue]);
        result(nil);
    } else if([@"playCustom" isEqualToString:call.method]) {
        NSString *name = (NSString *)call.arguments[@"name"];
        NSString *ext = (NSString *)call.arguments[@"ext"];

        SystemSoundID soundFileObject;
        NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource: name withExtension: ext];
        CFURLRef soundFileURLRef = CFBridgingRetain(soundFileURL);

        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundFileObject);
        AudioServicesPlayAlertSound(soundFileObject);
        CFRelease(soundFileURLRef);

    } else if ([@"stop" isEqualToString:call.method]) {
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
