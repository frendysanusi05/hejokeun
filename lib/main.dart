import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/utils/schedule_events.dart';
import 'firebase_options.dart';

import 'package:hejokeun/screens/home_screen.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/screens/auth/signup_screen.dart';
import 'package:hejokeun/screens/auth/signup_oauth_screen.dart';
import 'package:hejokeun/screens/auth/login_screen.dart';
import 'package:hejokeun/screens/welcome_screen.dart';
import 'package:hejokeun/screens/penukaran_poin/penukaran_poin_successful_screen.dart';
import 'package:hejokeun/screens/penukaran_poin/penukaran_poin_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializePickupScheduleData();
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
      initialRoute: PengambilanSampahScreen.id,
      // initialRoute: WelcomeScreen.id,
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
      },
    );
  }
}
