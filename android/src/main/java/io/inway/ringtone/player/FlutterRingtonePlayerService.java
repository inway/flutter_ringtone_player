package io.inway.ringtone.player;

import android.app.Service;
import android.content.Intent;
import android.media.AudioManager;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import androidx.annotation.Nullable;

public class FlutterRingtonePlayerService extends Service {
    public static final String RINGTONE_META_INTENT_EXTRA_KEY = "ringtone-meta";

    private Ringtone ringtone;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null) {
            final Bundle extras = intent.getExtras();

            if (extras == null) {
                throwInvalidArgumentsException();
            }

            final RingtoneMeta meta = (RingtoneMeta) extras.getSerializable(RINGTONE_META_INTENT_EXTRA_KEY);

            if (meta == null) {
                throwInvalidArgumentsException();
            }

            stopRingtone();
            startRingtone(meta);
        }

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        stopRingtone();
        super.onDestroy();
    }

    private void throwInvalidArgumentsException() {
        throw new IllegalArgumentException("Invalid arguments given");
    }

    private void stopRingtone() {
        if (ringtone != null) {
            ringtone.stop();
        }
        ringtone = null;
    }

    private void startRingtone(RingtoneMeta meta) {
        ringtone = getConfiguredRingtone(meta);
        ringtone.play();
    }

    private Ringtone getConfiguredRingtone(RingtoneMeta meta) {
        final Uri uri = getRingtoneUri(meta.getKind());
        final Ringtone ringtone = RingtoneManager.getRingtone(this, uri);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            ringtone.setLooping(Boolean.TRUE.equals(meta.getLooping()));
            if (meta.getVolume() != null) {
                ringtone.setVolume(meta.getVolume());
            }
        }
        if (Boolean.TRUE.equals(meta.getAsAlarm())) {
            ringtone.setStreamType(AudioManager.STREAM_ALARM);
        }

        return ringtone;
    }

    private Uri getRingtoneUri(int kind) {
        int ringtoneType = -1;

        switch (kind) {
            case 1:
                ringtoneType = RingtoneManager.TYPE_ALARM;
                break;

            case 2:
                ringtoneType = RingtoneManager.TYPE_NOTIFICATION;
                break;

            case 3:
                ringtoneType = RingtoneManager.TYPE_RINGTONE;
                break;

            default:
                throwInvalidArgumentsException();
        }
        return RingtoneManager.getDefaultUri(ringtoneType);
    }
}
