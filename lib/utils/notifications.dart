import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notifications {
  const Notifications(this.message, this.time, this.isOpened);

  final String message;
  final String time;
  final bool isOpened;
}

late Query notificationQuery;
late List<QueryDocumentSnapshot>? notificationDocuments;
List<Notifications> notifications = [];

Future<void> initializeNotifications() async {
  notificationQuery = FirebaseFirestore.instance
      .collection('notifications')
      .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  notificationDocuments = await getNotificationDocuments();

  if (notificationDocuments == null) {
    return;
  }

  clearNotifications();

  for (QueryDocumentSnapshot document in notificationDocuments!) {
    final timeDiff = DateTime.now()
        .difference((document.data() as Map<String, dynamic>)['time'].toDate());
    int dayDiff = timeDiff.inDays;
    int hourDiff = timeDiff.inHours.remainder(24);
    int minuteDiff = timeDiff.inMinutes.remainder(60);
    int secondDiff = timeDiff.inSeconds.remainder(60);

    String timeMessage;

    if (dayDiff > 0) {
      timeMessage = '$dayDiff hari yang lalu';
    } else if (hourDiff > 0) {
      timeMessage = '$hourDiff jam yang lalu';
    } else if (minuteDiff > 0) {
      timeMessage = '$minuteDiff menit yang lalu';
    } else {
      timeMessage = '$secondDiff detik yang lalu';
    }

    notifications.add(
      Notifications(
        (document.data() as Map<String, dynamic>)['message'],
        timeMessage,
        (document.data() as Map<String, dynamic>)['isOpened'],
      ),
    );
  }
}

Future<List<QueryDocumentSnapshot>?> getNotificationDocuments() async {
  try {
    QuerySnapshot notificationSnapshot = await notificationQuery.get();
    List<QueryDocumentSnapshot> notificationDocuments =
        notificationSnapshot.docs;
    if (notificationDocuments.isNotEmpty) {
      return notificationDocuments;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

List<Notifications> getNotifications() {
  return notifications;
}

void clearNotifications() {
  notifications.clear();
}

Future<void> readAllNotifications() async {
  for (QueryDocumentSnapshot document in notificationDocuments!) {
    await document.reference.update({
      'isOpened': true,
    });
  }
}
