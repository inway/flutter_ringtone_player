class AlarmNotificationMeta {
  final String activityClassLaunchedByIntent;
  final String iconDrawableResourceName;
  final String contentTitle;
  final String contentText;
  final String subText;

  AlarmNotificationMeta(this.activityClassLaunchedByIntent, this.iconDrawableResourceName,
      {this.contentTitle, this.contentText, this.subText});

  Map<String, dynamic> toMap() => {
        'activityClassLaunchedByIntent': activityClassLaunchedByIntent,
        'iconDrawableResourceName': iconDrawableResourceName,
        'contentTitle': contentTitle,
        'contentText': contentText,
        'subText': subText,
      };
}
