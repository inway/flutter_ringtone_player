package io.inway.ringtone.player;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;

import java.io.File;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterRingtonePlayerPlugin
 */
public class FlutterRingtonePlayerPlugin implements MethodCallHandler, FlutterPlugin {
    private Context context;
    private MethodChannel methodChannel;
    private RingtoneManager ringtoneManager;
    private static Ringtone ringtone;
    private MediaPlayer mediaPlayer;

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
            String uri = null;

            if (call.method.equals("play")) {

                if (call.hasArgument("uri")) {
                    uri = call.argument("uri");
                }

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

                if (uri != null && (uri.startsWith("/") || uri.startsWith("file://"))) {
                    try {
                        File file = new File(uri);
                        if (!file.exists() || !file.canRead()) {
                            throw new Exception("File does not exist or is not readable: " + uri);
                        }

                        if (mediaPlayer != null) {
                            mediaPlayer.stop();
                            mediaPlayer.release();
                            mediaPlayer = null;
                        }

                        mediaPlayer = new MediaPlayer();
                        mediaPlayer.setDataSource(uri);

                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                            mediaPlayer.setAudioAttributes(
                                    new AudioAttributes.Builder()
                                            .setUsage(AudioAttributes.USAGE_ALARM)
                                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                                            .build()
                            );
                        }

                        if (call.hasArgument("looping")) {
                            boolean looping = call.argument("looping");
                            mediaPlayer.setLooping(looping);
                        }

                        if (call.hasArgument("volume")) {
                            double volume = call.argument("volume");
                            mediaPlayer.setVolume((float) volume, (float) volume);
                        }

                        mediaPlayer.prepare();
                        mediaPlayer.start();

                        ringtone = null;

                        result.success(null);
                        return;
                    } catch (Exception e) {
                        e.printStackTrace();
                        result.error("FilePlaybackError", "Failed to play local file: " + e.getMessage(), null);
                        return;
                    }
                } else if (ringtoneUri == null && uri != null) {
                    ringtoneUri = Uri.parse(uri);
                }

                if (ringtoneUri != null) {
                    try {
                        if (ringtone != null) {
                            ringtone.stop();
                            ringtone = null;
                        }

                        ringtone = RingtoneManager.getRingtone(context, ringtoneUri);
                        if (ringtone == null) {
                            result.error("RingtoneError", "Failed to retrieve ringtone for URI: " + ringtoneUri.toString(), null);
                            return;
                        }

                        if (call.hasArgument("volume")) {
                            double volume = call.argument("volume");
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
                            if (asAlarm) {
                                ringtone.setAudioAttributes( new AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_ALARM).build() );
                            }
                        }

                        ringtone.play();
                        result.success(null);
                    } catch (Exception e) {
                        e.printStackTrace();
                        result.error("RingtonePlaybackError", "Error during ringtone playback: " + e.getMessage(), null);
                    }
                } else {
                    result.error("InvalidArguments", "No valid uri or android tone specified", null);
                }

            } else if (call.method.equals("stop")) {
                    if (ringtone != null) {
                        ringtone.stop();
                        ringtone = null;
                    }

                    if (mediaPlayer != null) {
                        mediaPlayer.stop();
                        mediaPlayer.release();
                        mediaPlayer = null;
                    }

                result.success(null);
            } else {
                result.notImplemented();
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.error("Exception", e.getMessage(), null);
        }
    }
}
