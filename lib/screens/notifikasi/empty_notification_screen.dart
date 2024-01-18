import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/notifikasi/notification_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class EmptyNotificationScreen extends StatelessWidget {
  const EmptyNotificationScreen({super.key});
  static String id = 'empty_notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: kH6.copyWith(color: kAG1),
        ),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const TopScreenImage(
              screenImageName: '404.png',
              width: 240.8,
              height: 160,
            ),
            const SizedBox(height: 28),
            Text(
              'Belum ada notifikasi untuk Anda',
              style: kBS2.copyWith(
                color: kDarkBrown,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, NotificationScreen.id);
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
              ),
              child: Text(
                'Refresh',
                style: kBS3.copyWith(
                  color: kAG1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
