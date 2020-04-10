package io.inway.ringtone.player;

import android.app.Service;
import android.content.Intent;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.IBinder;
import androidx.annotation.Nullable;

public class FlutterRingtonePlayerService extends Service {
    public static final String RINGTONE_URI_INTENT_EXTRA_KEY = "ringtone-uri";
    private final RingtoneManager ringtoneManager;

    private Ringtone ringtone;

    public FlutterRingtonePlayerService() {
        ringtoneManager = new RingtoneManager(this);
        ringtoneManager.setStopPreviousRingtone(true);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        final String ringtoneUri = intent.getExtras().getString(RINGTONE_URI_INTENT_EXTRA_KEY);

        if (ringtoneUri == null) {
            throw new IllegalArgumentException("No ringtone uri");
        }

        final int ringtonePosition = ringtoneManager.getRingtonePosition(Uri.parse(ringtoneUri));
        ringtone = ringtoneManager.getRingtone(ringtonePosition);
        ringtone.play();

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        ringtone.stop();
        super.onDestroy();
    }
}
