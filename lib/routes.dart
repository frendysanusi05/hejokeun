import 'package:flutter/material.dart';
import 'package:hejokeun/screens/auth/terms_and_condition_screen.dart';

import 'package:hejokeun/screens/maggot/maggot_indonesia_screen.dart';
import 'package:hejokeun/screens/maggot/membership/membership_order_successful_screen.dart';
import 'package:hejokeun/screens/maggot/membership/membership_screen.dart';
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
import 'package:hejokeun/screens/katalog_penukaran/pengambilan_sampah_successful_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah/request_pengambilan_sampah_screen.dart';
import 'package:hejokeun/screens/maggot/about_maggot_screen.dart';

class Routes {
  static String welcome = WelcomeScreen.id;
  static String signup = SignUpScreen.id;
  static String signupOauth = SignUpOauthScreen.id;
  static String login = LoginScreen.id;
  static String termsAndCondition = TermsAndConditionScreen.id;
  static String main = MainScreen.id;
  static String penukaranPoin = PenukaranPoinScreen.id;
  static String penukaranPoinSuccessful = PenukaranPoinSuccessfulScreen.id;
  static String pengambilanSampah = PengambilanSampahScreen.id;
  static String requestPengambilanSampah = RequestPengambilanSampahScreen.id;
  static String pengambilanSampahSuccessful =
      PengambilanSampahSuccessfulScreen.id;
  static String emptyNotification = EmptyNotificationScreen.id;
  static String notEmptyNotification = NotEmptyNotificationScreen.id;
  static String notification = NotificationScreen.id;
  static String emptyTransactionHistory = EmptyTransactionHistoryScreen.id;
  static String notEmptyTransactionHistory =
      NotEmptyTransactionHistoryScreen.id;
  static String transactionHistory = TransactionHistoryScreen.id;
  static String aboutMaggot = AboutMaggotScreen.id;
  static String maggotIndonesia = MaggotIndonesiaScreen.id;
  static String membership = MembershipScreen.id;
  static String membershipOrderSuccessful = MembershipOrderSuccessfulScreen.id;

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignUpScreen(),
    signupOauth: (context) => const SignUpOauthScreen(),
    login: (context) => const LoginScreen(),
    termsAndCondition: (context) => const TermsAndConditionScreen(),
    main: (context) => const MainScreen(),
    penukaranPoin: (context) => const PenukaranPoinScreen(),
    penukaranPoinSuccessful: (context) => const PenukaranPoinSuccessfulScreen(),
    pengambilanSampah: (context) => const PengambilanSampahScreen(),
    requestPengambilanSampah: (context) =>
        const RequestPengambilanSampahScreen(),
    pengambilanSampahSuccessful: (context) =>
        const PengambilanSampahSuccessfulScreen(),
    emptyNotification: (context) => const EmptyNotificationScreen(),
    notEmptyNotification: (context) => const NotEmptyNotificationScreen(),
    notification: (context) => const NotificationScreen(),
    emptyTransactionHistory: (context) => const EmptyTransactionHistoryScreen(),
    notEmptyTransactionHistory: (context) =>
        const NotEmptyTransactionHistoryScreen(),
    transactionHistory: (context) => const TransactionHistoryScreen(),
    aboutMaggot: (context) => const AboutMaggotScreen(),
    maggotIndonesia: (context) => const MaggotIndonesiaScreen(),
    membership: (context) => const MembershipScreen(),
    membershipOrderSuccessful: (context) =>
        const MembershipOrderSuccessfulScreen(),
  };
}
