import 'package:flutter/material.dart';
import 'package:hejokeun/screens/notifikasi/empty_notification_screen.dart';
import 'package:hejokeun/screens/notifikasi/not_empty_notification_screen.dart';
import 'package:hejokeun/utils/notifications.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static String id = 'notifications_screen';

  @override
  Widget build(BuildContext context) {
    List<Notifications> notifications = getNotifications();

    return notifications.isEmpty
        ? const EmptyNotificationScreen()
        : const NotEmptyNotificationScreen();
  }
}
