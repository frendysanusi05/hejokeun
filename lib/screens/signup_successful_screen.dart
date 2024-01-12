import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/login_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class SignUpSuccessfullScreen extends StatefulWidget {
  const SignUpSuccessfullScreen({super.key});
  static String id = 'register_successful_screen';

  @override
  State<SignUpSuccessfullScreen> createState() => _SignUpSuccessfullScreen();
}

class _SignUpSuccessfullScreen extends State<SignUpSuccessfullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 220),
            const TopScreenImage(
              screenImageName: 'register_successful.png',
              width: 319.92,
              height: 238.33,
            ),
            const SizedBox(height: 36),
            const ScreenTitle(title: 'Akun Anda berhasil dibuat'),
            const SizedBox(height: 64),
            Hero(
              tag: 'login_btn',
              child: CustomButton(
                buttonText: 'Log In',
                buttonColor: kAG1,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
