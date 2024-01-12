// import 'package:fe_hejokeun/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/login_screen.dart';
import 'package:hejokeun/screens/signup_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const TopScreenImage(
                screenImageName: 'logo.png',
                width: 165.38,
                height: 200,
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ScreenTitle(title: 'Selamat datang di Hejokeun!'),
                    const Text(
                      'Aplikasi Eco green ...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kDarkBrown, fontSize: kBR4),
                    ),
                    const SizedBox(height: 103),
                    Hero(
                      tag: 'signup_btn',
                      child: CustomButton(
                        buttonText: 'Sign Up',
                        buttonColor: kAG1,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Hero(
                      tag: 'continue_with_google_btn',
                      child: CustomButton(
                        buttonText: 'Continue with Google',
                        isOutlined: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Hero(
                      tag: 'continue_with_facebook_btn',
                      child: CustomButton(
                        buttonText: 'Continue with Facebook',
                        isOutlined: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Hero(
                      tag: 'login_btn',
                      child: CustomButton(
                        buttonText: 'Log In',
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
