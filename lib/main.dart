import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'package:hejokeun/screens/signup_oauth_screen.dart';
import 'package:hejokeun/screens/home_screen.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/screens/signup_screen.dart';
import 'package:hejokeun/screens/login_screen.dart';
import 'package:hejokeun/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      },
    );
  }
}
