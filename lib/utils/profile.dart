import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  const Profile(this.fullname, this.email, this.phone, this.homeUniqueCode);

  final String fullname;
  final String email;
  final String phone;
  final String homeUniqueCode;
}

late Query profileQuery;
late List<QueryDocumentSnapshot>? profileDocuments;
late Profile profile;

Future<void> initializeProfile() async {
  profileQuery = FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  profileDocuments = await getProfileDocuments();

  if (profileDocuments == null) {
    return;
  }

  for (QueryDocumentSnapshot document in profileDocuments!) {
    profile = Profile(
      (document.data() as Map<String, dynamic>)['fullname'],
      (document.data() as Map<String, dynamic>)['email'],
      formatPhoneNumber((document.data() as Map<String, dynamic>)['phone']),
      (document.data() as Map<String, dynamic>)['home_unique_code'],
    );
  }
}

Future<List<QueryDocumentSnapshot>?> getProfileDocuments() async {
  try {
    QuerySnapshot notificationSnapshot = await profileQuery.get();
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

String formatPhoneNumber(String phoneNumber) {
  phoneNumber =
      phoneNumber.startsWith('+') ? phoneNumber.substring(1) : phoneNumber;

  phoneNumber =
      '+${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 6)}-${phoneNumber.substring(6, 10)}-${phoneNumber.substring(10)}';

  return phoneNumber;
}
