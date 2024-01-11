import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hejokeun/auth.dart';
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
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController fullnameController;
  late final TextEditingController nicknameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);
    fullnameController = TextEditingController()
      ..addListener(controllerListeners);
    nicknameController = TextEditingController()
      ..addListener(controllerListeners);
    passwordController = TextEditingController()
      ..addListener(controllerListeners);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    fullnameController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final fullname = fullnameController.text;
    final nickname = nicknameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty &&
        fullname.isEmpty &&
        nickname.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      return;
    }

    if (AppRegex.emailRegex.hasMatch(email) && password == confirmPassword) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      addUserDetails(
        fullnameController.text,
        nicknameController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> addUserDetails(
    String fullname,
    String nickname,
  ) async {
    try {
      final users = FirebaseFirestore.instance.collection('users');
      users.add({
        'fullname': fullname,
        'nickname': nickname,
      });
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
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
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    controller: fullnameController,
                    fieldText: "Nama Lengkap",
                    labelText: "Masukkan nama lengkap Anda",
                    required: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    onChanged: (_) => _formKey.currentState?.validate(),
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: nicknameController,
                    fieldText: "Nama Panggilan",
                    labelText: "Masukkan nama panggilan Anda",
                    required: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    onChanged: (_) => _formKey.currentState?.validate(),
                  ),
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
                      return value!.isEmpty
                          ? "Masukkan e-mail Anda"
                          : AppRegex.emailRegex.hasMatch(value)
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
                          return value!.isEmpty
                              ? "Masukkan password Anda"
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
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: confirmPasswordNotifier,
                    builder: (_, confirmPasswordObscure, __) {
                      return AppTextFormField(
                        controller: confirmPasswordController,
                        fieldText: "Konfirmasi Password",
                        labelText: "Masukkan kembali password Anda",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: confirmPasswordObscure,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? "Masukkan kembali password Anda"
                              : passwordController.text ==
                                      confirmPasswordController.text
                                  ? null
                                  : "Password tidak sama";
                        },
                        suffixIcon: Focus(
                          /// If false,
                          ///
                          /// disable focus for all of this node's descendants.
                          descendantsAreFocusable: false,

                          /// If false,
                          ///
                          /// make this widget's descendants un-traversable.
                          // descendantsAreTraversable: false,
                          child: IconButton(
                            onPressed: () => confirmPasswordNotifier.value =
                                !confirmPasswordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              confirmPasswordObscure
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
                  buttonText: 'Sign Up',
                  buttonColor: kAG0,
                  textColor: Colors.white,
                  isDisabled: !isValid,
                  onPressed: createUserWithEmailAndPassword,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}