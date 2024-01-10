import 'package:hejokeun/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/utils/app_regex.dart';
import 'package:hejokeun/utils/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(true);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);
    passwordController = TextEditingController()
      ..addListener(controllerListeners);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
      return;
    }

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            const ScreenTitle(title: 'Selamat datang di Hejokeun!'),
            const Text(
              'Masukkan e-mail dan password yang ingin Anda gunakan',
              style: TextStyle(
                color: kAG3,
                fontSize: kBR4,
              ),
            ),
            const SizedBox(height: 24),
            Form(
              child: Column(
                children: [
                  AppTextFormField(
                    controller: emailController,
                    fieldText: "E-mail",
                    labelText: "Masukkan e-mail Anda",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: passwordController,
                    fieldText: "Password",
                    labelText: "Masukkan password Anda",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: confirmPasswordController,
                    fieldText: "Konfirmasi Password",
                    labelText: "Masukkan kembali password Anda",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.visiblePassword,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
