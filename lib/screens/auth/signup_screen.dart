import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/auth.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/auth/terms_and_condition_screen.dart';
import 'package:hejokeun/screens/main_screen.dart';
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
  late final TextEditingController phoneController;
  late final TextEditingController homeUniqueCodeController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController isTermsCheckedController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> isTermsCheckedNotifier = ValueNotifier<bool>(false);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);
    fullnameController = TextEditingController()
      ..addListener(controllerListeners);
    nicknameController = TextEditingController()
      ..addListener(controllerListeners);
    phoneController = TextEditingController()..addListener(controllerListeners);
    homeUniqueCodeController = TextEditingController()
      ..addListener(controllerListeners);
    passwordController = TextEditingController()
      ..addListener(controllerListeners);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListeners);
    isTermsCheckedController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    fullnameController.dispose();
    nicknameController.dispose();
    phoneController.dispose();
    homeUniqueCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isTermsCheckedController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final fullname = fullnameController.text;
    final nickname = nicknameController.text;
    final phone = phoneController.text;
    final homeUniqueCode = homeUniqueCodeController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    errorMessage = '';

    bool fieldIsEmpty = email.isEmpty ||
        fullname.isEmpty ||
        nickname.isEmpty ||
        phone.isEmpty ||
        homeUniqueCode.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty;

    if (AppRegex.emailRegex.hasMatch(email) &&
        password == confirmPassword &&
        !fieldIsEmpty &&
        isTermsCheckedNotifier.value) {
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

      await addUserDetails(
        FirebaseAuth.instance.currentUser!.uid,
        fullnameController.text,
        nicknameController.text,
        phoneController.text,
        homeUniqueCodeController.text,
        emailController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });

      _formKey.currentState?.validate();
    }
  }

  Future<void> addUserDetails(
    String uid,
    String fullname,
    String nickname,
    String phone,
    String homeUniqueCode,
    String email,
  ) async {
    try {
      final users = FirebaseFirestore.instance.collection('users');
      final docRef = users.doc(uid);
      docRef.set({
        'id': uid,
        'fullname': fullname,
        'nickname': nickname,
        'phone': '+62$phone',
        'home_unique_code': homeUniqueCode,
        'email': email,
        'point': 0,
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
            Text(
              'Masukkan e-mail dan password yang ingin Anda gunakan',
              style: kBR4.copyWith(
                color: kAG3,
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
                  AppPhoneFormField(
                    controller: phoneController,
                    fieldText: "Nomor Telepon",
                    labelText: "Masukkan nomor telepon Anda",
                    required: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    onChanged: (_) => _formKey.currentState?.validate(),
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: homeUniqueCodeController,
                    fieldText: "Kode Unik Rumah",
                    labelText: "Masukkan kode unik rumah Anda",
                    required: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
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
                      return errorMessage!.isNotEmpty
                          ? "E-mail Anda sudah digunakan"
                          : value!.isEmpty
                              ? null
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
                              ? null
                              : value.length >= 6
                                  ? null
                                  : "Password minimal 6 karakter";
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
                          return passwordController.text ==
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
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: kAG1,
                    value: isTermsCheckedNotifier.value,
                    onChanged: (value) {
                      setState(() {
                        isTermsCheckedNotifier.value = value!;
                        isTermsCheckedController.text = value.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 313,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kAG2,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Saya telah membaca dan menyetujui ',
                        ),
                        TextSpan(
                          text: 'Syarat dan Ketentuan',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, TermsAndConditionScreen.id);
                            },
                        ),
                        const TextSpan(
                          text: ' yang berlaku',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: fieldValidNotifier,
              builder: (_, isValid, __) {
                return CustomButton(
                  buttonText: 'Sign Up',
                  buttonColor: kAG1,
                  textColor: Colors.white,
                  isDisabled: !isValid,
                  onPressed: () async {
                    await createUserWithEmailAndPassword();
                    Navigator.pushNamed(context, MainScreen.id);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
