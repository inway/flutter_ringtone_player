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

- (void)playSound:(SystemSoundID)soundId count:(int)count {
    AudioServicesPlaySystemSoundWithCompletion(soundId, ^{
//        NSLog(@"sound playing done ");
        if (count > 1) {
//            NSLog(@"sound loop....  %d",count);
            [self playSound:soundId count:count - 1];
        } else {
            return;
        }
    });
};

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
            soundId = (SystemSoundID)
            [call.arguments[@"ios"] integerValue];
        }
        if (call.arguments[@"repeatTime"] != nil) {
            int repeatTime = [call.arguments[@"repeatTime"] integerValue];
            [self playSound:soundId count:repeatTime];
        } else {
            AudioServicesPlaySystemSound(soundId);
        }
        if (soundFileURLRef != nil) {
            CFRelease(soundFileURLRef);
        }
        NSString *soundIDString = [NSString stringWithFormat:@"%d", soundId];
        result(soundIDString);
//        result(nil);
    } else if ([@"stop" isEqualToString:call.method]) {
        SystemSoundID
        soundId = (SystemSoundID)
        [call.arguments[@"soundId"] integerValue];
        AudioServicesDisposeSystemSoundID(soundId);
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
