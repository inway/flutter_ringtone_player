package io.inway.ringtone.player;

import java.io.Serializable;

public class RingtoneMeta implements Serializable {
    private int kind;
    private Float volume;
    private Boolean looping;
    private Boolean asAlarm;
    private AlarmNotificationMeta alarmNotificationMeta;

    public void setKind(int kind) {
        this.kind = kind;
    }

    public int getKind() {
        return kind;
    }

    public void setVolume(Float volume) {
        this.volume = volume;
    }

    public Float getVolume() {
        return volume;
    }

    public void setLooping(Boolean looping) {
        this.looping = looping;
    }

    public boolean getLooping() {
        return Boolean.TRUE.equals(looping);
    }

    public void setAsAlarm(Boolean asAlarm) {
        this.asAlarm = asAlarm;
    }

    public boolean getAsAlarm() {
        return Boolean.TRUE.equals(asAlarm);
    }

    public AlarmNotificationMeta getAlarmNotificationMeta() {
        return alarmNotificationMeta;
    }

    public void setAlarmNotificationMeta(AlarmNotificationMeta alarmNotificationMeta) {
        this.alarmNotificationMeta = alarmNotificationMeta;
    }
}
