import 'package:flutter/material.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/notifications.dart';

class NotEmptyNotificationScreen extends StatelessWidget {
  const NotEmptyNotificationScreen({super.key});
  static String id = 'not_empty_notification_screen';

  @override
  Widget build(BuildContext context) {
    List<Notifications> notifications = getNotifications();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifikasi',
            style: kH6.copyWith(color: kAG1),
          ),
          leading: BackButton(
            onPressed: () async {
              await readAllNotifications();
              await initializeNotifications();
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 21),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              notifications[index].isOpened
                                  ? Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF3C3C43)
                                            .withOpacity(0.18),
                                      ),
                                    )
                                  : Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF6BC125),
                                      ),
                                    ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Text(
                                  notifications[index].message,
                                  style: kBR3.copyWith(color: kDarkBrown),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notifications[index].time,
                            style: kBR5.copyWith(color: kCamel),
                          ),
                          const SizedBox(height: 8.0),
                          Divider(
                            height: 0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
