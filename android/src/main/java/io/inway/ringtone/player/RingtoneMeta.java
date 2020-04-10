package io.inway.ringtone.player;

import java.io.Serializable;

public class RingtoneMeta implements Serializable {
    private int kind;
    private Float volume;
    private Boolean looping;
    private Boolean asAlarm;

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

    public Boolean getLooping() {
        return looping;
    }

    public void setAsAlarm(Boolean asAlarm) {
        this.asAlarm = asAlarm;
    }

    public Boolean getAsAlarm() {
        return asAlarm;
    }
}
