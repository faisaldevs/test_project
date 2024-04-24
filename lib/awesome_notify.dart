import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotify {
  void requestNotificationPermission() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  triggerNotification(title,body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 12,
      channelKey: "channelKey",
      title: title,
      body: body,
    ));
  }
}
