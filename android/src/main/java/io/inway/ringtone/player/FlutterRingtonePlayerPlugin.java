package io.inway.ringtone.player;


import android.content.Context;
import android.media.AudioManager;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;


import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterRingtonePlayerPlugin
 */
public class FlutterRingtonePlayerPlugin implements MethodCallHandler, FlutterPlugin {
    private Context context;
    private MethodChannel methodChannel;
    private RingtoneManager ringtoneManager;
    private Ringtone ringtone;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        this.context = applicationContext;
        this.ringtoneManager = new RingtoneManager(context);
        this.ringtoneManager.setStopPreviousRingtone(true);

        methodChannel = new MethodChannel(messenger, "flutter_ringtone_player");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        context = null;
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }


    @SuppressWarnings("ConstantConditions")
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        try {
            Uri ringtoneUri = null;
            if (call.method.equals("play")) {
                if (call.hasArgument("uri")) {
                    String uri = call.argument("uri");
                    ringtoneUri = Uri.parse(uri);
                }

                // The androidSound overrides fromAsset if exists
                if (call.hasArgument("android")) {
                    int pref = call.argument("android");
                    switch (pref) {
                        case 1:
                            ringtoneUri = ringtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.TYPE_ALARM);
                            break;
                        case 2:
                            ringtoneUri = ringtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.TYPE_NOTIFICATION);
                            break;
                        case 3:
                            ringtoneUri = ringtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.TYPE_RINGTONE);
                            break;
                        default:
                            result.notImplemented();
                    }

                }
            } else if (call.method.equals("stop")) {
                if (ringtone != null) {
                    ringtone.stop();
                }

                result.success(null);
            }

            if (ringtoneUri != null) {
                if (ringtone != null) {
                    ringtone.stop();
                }
                ringtone = RingtoneManager.getRingtone(context, ringtoneUri);

                if (call.hasArgument("volume")) {
                    final double volume = call.argument("volume");
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        ringtone.setVolume((float) volume);
                    }
                }

                if (call.hasArgument("looping")) {
                    final boolean looping = call.argument("looping");
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        ringtone.setLooping(looping);
                    }
                }

                if (call.hasArgument("asAlarm")) {
                    final boolean asAlarm = call.argument("asAlarm");
                    /* There's also a .setAudioAttributes method
                       that is more flexible, but .setStreamType
                       is supported in all Android versions
                       whereas .setAudioAttributes needs SDK > 21.
                       More on that at
                       https://developer.android.com/reference/android/media/Ringtone
                    */
                    if (asAlarm) {
                        ringtone.setStreamType(AudioManager.STREAM_ALARM);
                    }
                }

                ringtone.play();

                result.success(null);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.error("Exception", e.getMessage(), null);
        }
    }
}
