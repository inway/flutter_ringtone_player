package io.inway.ringtone.player;

import android.content.Context;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterRingtonePlayerPlugin
 */
public class FlutterRingtonePlayerPlugin implements MethodCallHandler {
  private final Context context;
  private final RingtoneManager ringtoneManager;
  private Ringtone ringtone;

  public FlutterRingtonePlayerPlugin(Context context) {
    this.context = context;
    this.ringtoneManager = new RingtoneManager(context);
    this.ringtoneManager.setStopPreviousRingtone(true);
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_ringtone_player");
    channel.setMethodCallHandler(new FlutterRingtonePlayerPlugin(registrar.context()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      Uri ringtoneUri = null;

      switch (call.method) {
        case "playAlarm":
          ringtoneUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);
          break;
        case "playNotification":
          ringtoneUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
          break;
        case "playRingtone":
          ringtoneUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE);
          break;
        case "stop":
          if (ringtone != null) {
            ringtone.stop();
          }
          break;
        default:
          result.notImplemented();
      }

      if (ringtoneUri != null) {
        if (ringtone != null) {
          ringtone.stop();
        }
        ringtone = ringtoneManager.getRingtone(context, ringtoneUri);

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

        ringtone.play();
      }

      result.success(null);
    } catch (Exception e) {
      e.printStackTrace();
      result.error("Exception", e.getMessage(), null);
    }
  }
}
