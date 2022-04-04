#import "FlutterRingtonePlayerPlugin.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation FlutterRingtonePlayerPlugin
NSObject <FlutterPluginRegistrar> *pluginRegistrar = nil;

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    pluginRegistrar = registrar;
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"flutter_ringtone_player"
                  binaryMessenger:[registrar messenger]];
    FlutterRingtonePlayerPlugin *instance = [[FlutterRingtonePlayerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"play" isEqualToString:call.method]) {
        SystemSoundID soundId = nil;
        CFURLRef soundFileURLRef = nil;

        if (call.arguments[@"uri"] != nil) {
            NSString *key = [pluginRegistrar lookupKeyForAsset:call.arguments[@"uri"]];
            NSURL *path = [[NSBundle mainBundle] URLForResource:key withExtension:nil];
            soundFileURLRef = CFBridgingRetain(path);
            AudioServicesCreateSystemSoundID(soundFileURLRef, &soundId);
        }

        // The iosSound overrides fromAsset if exists
        if (call.arguments[@"ios"] != nil) {
            soundId = (SystemSoundID) [call.arguments[@"ios"] integerValue];
        }

        AudioServicesPlaySystemSound(soundId);
        if (soundFileURLRef != nil) {
            CFRelease(soundFileURLRef);
        }

        result(nil);
    } else if ([@"stop" isEqualToString:call.method]) {
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
