import 'package:flutter/material.dart';
import 'package:hejokeun/auth.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/auth/login_screen.dart';
import 'package:hejokeun/screens/auth/signup_oauth_screen.dart';
import 'package:hejokeun/screens/auth/signup_screen.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (Auth().currentUser != null) {
        Navigator.pushNamed(context, MainScreen.id);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 169,
              ),
              const TopScreenImage(
                screenImageName: 'logo.png',
                width: 306,
                height: 294,
              ),
              const SizedBox(height: 105),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                        onPressed: () async {
                          await Auth().signInWithGoogle();

                          bool userExist = await Auth().checkUserExist();

                          if (userExist) {
                            Navigator.pushNamed(context, MainScreen.id);
                          } else {
                            Navigator.pushNamed(context, SignUpOauthScreen.id);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Hero(
                      tag: 'continue_with_facebook_btn',
                      child: CustomButton(
                        buttonText: 'Continue with Facebook',
                        isOutlined: true,
                        onPressed: () async {
                          await Auth().signInWithFacebook();
                          bool userExist = await Auth().checkUserExist();

                          if (userExist) {
                            Navigator.pushNamed(context, MainScreen.id);
                          } else {
                            Navigator.pushNamed(context, SignUpOauthScreen.id);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Hero(
                      tag: 'login_btn',
                      child: CustomButton(
                        buttonText: 'Log In with E-mail',
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
