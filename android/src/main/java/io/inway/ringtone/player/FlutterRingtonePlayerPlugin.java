package io.inway.ringtone.player;


import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.Map;

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
            final String methodName = call.method;

            if (methodName.equals("play")) {
                final RingtoneMeta meta = createRingtoneMeta(call);
                startRingtone(meta);
                result.success(null);
            } else if (methodName.equals("stop")) {
                stopRingtone();
                result.success(null);
            }
        } catch (Exception e) {
            result.error("Exception", e.getMessage(), null);
        }
    }

    private RingtoneMeta createRingtoneMeta(MethodCall call) {
        if (!call.hasArgument("android")) {
            throw new IllegalArgumentException("android argument is missing");
        }

        final RingtoneMeta meta = new RingtoneMeta();
        meta.setKind(getMethodCallArgument(call, "android", Integer.class));
        meta.setLooping(getMethodCallArgument(call, "looping", Boolean.class));
        meta.setAsAlarm(getMethodCallArgument(call, "asAlarm", Boolean.class));
        final Double volume = getMethodCallArgument(call, "volume", Double.class);
        if (volume != null) {
            meta.setVolume(volume.floatValue());
        }

        if (meta.getAsAlarm()) {
            final String alarmNotificationMetaKey = "alarmNotificationMeta";

            if (call.hasArgument(alarmNotificationMetaKey)) {
                final Map<String, Object> notificationMetaValues = getMethodCallArgument(call, alarmNotificationMetaKey, Map.class);
                final AlarmNotificationMeta notificationMeta = new AlarmNotificationMeta(notificationMetaValues);
                meta.setAlarmNotificationMeta(notificationMeta);
            } else {
                throw new IllegalArgumentException("if asAlarm=true you have to deliver '" + alarmNotificationMetaKey + "'");
            }
        }

        return meta;
    }

    private void startRingtone(RingtoneMeta meta) {
        final Intent intent = createServiceIntent();
        intent.putExtra(FlutterRingtonePlayerService.RINGTONE_META_INTENT_EXTRA_KEY, meta);

        if (meta.getAsAlarm()) {
            ContextCompat.startForegroundService(context, intent);
        } else {
            context.startService(intent);
        }
    }

    private void stopRingtone() {
        final Intent intent = createServiceIntent();
        context.stopService(intent);
    }

    private <ArgumentType> ArgumentType getMethodCallArgument(MethodCall call, String key, Class<ArgumentType> argumentTypeClass) {
        return call.argument(key);
    }

    private Intent createServiceIntent() {
        return new Intent(context, FlutterRingtonePlayerService.class);
    }
}
