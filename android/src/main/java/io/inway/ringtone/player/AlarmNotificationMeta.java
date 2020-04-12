package io.inway.ringtone.player;

import java.io.Serializable;
import java.util.Map;

public class AlarmNotificationMeta implements Serializable {
    private final Map<String, Object> notificationMetaValues;

    public AlarmNotificationMeta(Map<String, Object> notificationMetaValues) {
        this.notificationMetaValues = notificationMetaValues;
    }

    public CharSequence getContentTitle() {
        return (CharSequence) notificationMetaValues.get("contentTitle");
    }

    public CharSequence getContentText() {
        return (CharSequence) notificationMetaValues.get("contentText");
    }

    public CharSequence getSubText() {
        return (CharSequence) notificationMetaValues.get("subText");
    }

    public String getIconDrawableResourceName() {
        return (String) notificationMetaValues.get("iconDrawableResourceName");
    }

    public String getActivityClassLaunchedByIntent() {
        return (String) notificationMetaValues.get("activityClassLaunchedByIntent");
    }
}
