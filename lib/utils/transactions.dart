import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transactions {
  const Transactions(this.type, this.point, this.datetime, this.isGained);

  final String type;
  final String point;
  final String datetime;
  final bool isGained;
}

late Query transactionQuery;
late List<QueryDocumentSnapshot>? transactionDocuments;
List<Transactions> transactions = [];

Future<void> initializeTransactions() async {
  transactionQuery = FirebaseFirestore.instance
      .collection('transactions')
      .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  transactionDocuments = await getTransactionDocuments();

  if (transactionDocuments == null) {
    return;
  }

  clearTransactions();

  for (QueryDocumentSnapshot document in transactionDocuments!) {
    final datetime = (document.data() as Map<String, dynamic>)['time'];

    String year = getYearFromTimeStamp(datetime).toString();
    String month = getMonthFromTimeStamp(datetime).toString();
    String day = getDayFromTimeStamp(datetime).toString();
    String hour = getHourFromTimeStamp(datetime).toString();
    String minute = getMinuteFromTimeStamp(datetime).toString();

    if (month.length == 1) {
      month = '0$month';
    }
    if (day.length == 1) {
      day = '0$day';
    }
    if (hour.length == 1) {
      hour = '0$hour';
    }
    if (minute.length == 1) {
      minute = '0$minute';
    }

    String datetimeMessage = '$day-$month-$year, $hour:$minute';

    String pointMessage = '';
    int point = (document.data() as Map<String, dynamic>)['point'];
    bool isGained = (document.data() as Map<String, dynamic>)['isGained'];
    if (isGained) {
      pointMessage = '+$point Poin';
    } else {
      pointMessage = '-$point Poin';
    }

    transactions.add(
      Transactions(
        isGained ? 'Penjualan Sampah' : 'Pencairan Poin',
        pointMessage,
        datetimeMessage,
        isGained,
      ),
    );
  }
}

Future<List<QueryDocumentSnapshot>?> getTransactionDocuments() async {
  try {
    QuerySnapshot transactionSnapshot = await transactionQuery.get();
    List<QueryDocumentSnapshot> transactionDocuments = transactionSnapshot.docs;
    if (transactionDocuments.isNotEmpty) {
      return transactionDocuments;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

List<Transactions> getTransactions() {
  return transactions;
}

void clearTransactions() {
  transactions.clear();
}

int getYearFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.year;
}

int getMonthFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.month;
}

int getDayFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.day;
}

int getHourFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.hour;
}

int getMinuteFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.minute;
}
