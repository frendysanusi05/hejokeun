import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/utils/transactions.dart';
import 'firebase_options.dart';
import 'package:hejokeun/utils/notifications.dart';
import 'package:hejokeun/utils/schedule_events.dart';

import 'package:hejokeun/screens/home_screen.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/screens/auth/signup_screen.dart';
import 'package:hejokeun/screens/auth/signup_oauth_screen.dart';
import 'package:hejokeun/screens/auth/login_screen.dart';
import 'package:hejokeun/screens/welcome_screen.dart';
import 'package:hejokeun/screens/penukaran_poin/penukaran_poin_successful_screen.dart';
import 'package:hejokeun/screens/penukaran_poin/penukaran_poin_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah/pengambilan_sampah_screen.dart';
import 'package:hejokeun/screens/notifikasi/empty_notification_screen.dart';
import 'package:hejokeun/screens/notifikasi/not_empty_notification_screen.dart';
import 'package:hejokeun/screens/notifikasi/notification_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/empty_transaction_history_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/not_empty_transaction_history_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/transaction_history_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah/pengambilan_sampah_successful_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah/request_pengambilan_sampah_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializePickupScheduleData();
  await initializeNotifications();
  await initializeTransactions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hejokeun',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        SignUpOauthScreen.id: (context) => const SignUpOauthScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        MainScreen.id: (context) => const MainScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        PenukaranPoinScreen.id: (context) => const PenukaranPoinScreen(),
        PenukaranPoinSuccessfulScreen.id: (context) =>
            const PenukaranPoinSuccessfulScreen(),
        PengambilanSampahScreen.id: (context) =>
            const PengambilanSampahScreen(),
        RequestPengambilanSampahScreen.id: (context) =>
            const RequestPengambilanSampahScreen(),
        PengambilanSampahSuccessfulScreen.id: (context) =>
            const PengambilanSampahSuccessfulScreen(),
        EmptyNotificationScreen.id: (context) =>
            const EmptyNotificationScreen(),
        NotEmptyNotificationScreen.id: (context) =>
            const NotEmptyNotificationScreen(),
        NotificationScreen.id: (context) => const NotificationScreen(),
        EmptyTransactionHistoryScreen.id: (context) =>
            const EmptyTransactionHistoryScreen(),
        NotEmptyTransactionHistoryScreen.id: (context) =>
            const NotEmptyTransactionHistoryScreen(),
        TransactionHistoryScreen.id: (context) =>
            const TransactionHistoryScreen(),
      },
    );
  }
}
