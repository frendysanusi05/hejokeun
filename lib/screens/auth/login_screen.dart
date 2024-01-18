import 'package:firebase_auth/firebase_auth.dart';
import 'package:hejokeun/auth.dart';
import 'package:hejokeun/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/app_regex.dart';
import 'package:hejokeun/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);

    passwordController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final password = passwordController.text;

    errorMessage = '';

    bool fieldIsEmpty = email.isEmpty || password.isEmpty;

    if (!fieldIsEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _formKey.currentState?.validate();
      showErrorMessage();
    }
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: CustomSnackBarContent(
          message: 'E-mail atau password salah',
        ),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // margin: const EdgeInsets.only(
        //   bottom: 750,
        //   left: 10,
        //   right: 10,
        // ),
      ),
    );
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
            const ScreenTitle(title: 'Selamat datang kembali!'),
            Text(
              'Masukkan e-mail dan password akun Anda',
              style: kBR4.copyWith(
                color: kAG3,
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: emailController,
                    fieldText: "E-mail",
                    labelText: "Masukkan e-mail Anda",
                    required: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return errorMessage!.isNotEmpty
                          ? "E-mail Anda salah"
                          : AppRegex.emailRegex.hasMatch(value!)
                              ? null
                              : "E-mail Anda invalid";
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool>(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return AppTextFormField(
                        controller: passwordController,
                        fieldText: "Password",
                        labelText: "Masukkan password Anda",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: passwordObscure,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return errorMessage!.isNotEmpty
                              ? "Password Anda salah"
                              : null;
                        },
                        suffixIcon: Focus(
                          /// If false,
                          ///
                          /// disable focus for all of this node's descendants
                          descendantsAreFocusable: false,

                          /// If false,
                          ///
                          /// make this widget's descendants un-traversable.
                          // descendantsAreTraversable: false,
                          child: IconButton(
                            onPressed: () =>
                                passwordNotifier.value = !passwordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              passwordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            ValueListenableBuilder(
              valueListenable: fieldValidNotifier,
              builder: (_, isValid, __) {
                return CustomButton(
                    buttonText: 'Log In',
                    buttonColor: kAG0,
                    textColor: Colors.white,
                    isDisabled: !isValid,
                    onPressed: () async {
                      await signInWithEmailAndPassword();
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainScreen.id, (route) => false);
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
