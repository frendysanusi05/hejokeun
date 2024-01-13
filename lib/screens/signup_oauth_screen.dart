import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hejokeun/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/screens/signup_successful_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class SignUpOauthScreen extends StatefulWidget {
  const SignUpOauthScreen({super.key});
  static String id = 'signup_oauth_screen';

  @override
  State<SignUpOauthScreen> createState() => _SignUpOauthScreenState();
}

class _SignUpOauthScreenState extends State<SignUpOauthScreen> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController fullnameController;
  late final TextEditingController nicknameController;
  late final TextEditingController phoneController;
  late final TextEditingController homeUniqueCodeController;
  late final TextEditingController isTermsCheckedController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isTermsCheckedNotifier = ValueNotifier<bool>(false);

  void initializeControllers() {
    fullnameController = TextEditingController()
      ..addListener(controllerListeners);
    nicknameController = TextEditingController()
      ..addListener(controllerListeners);
    phoneController = TextEditingController()..addListener(controllerListeners);
    homeUniqueCodeController = TextEditingController()
      ..addListener(controllerListeners);
    isTermsCheckedController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    fullnameController.dispose();
    nicknameController.dispose();
    phoneController.dispose();
    homeUniqueCodeController.dispose();
    isTermsCheckedController.dispose();
  }

  void controllerListeners() {
    final fullname = fullnameController.text;
    final nickname = nicknameController.text;
    final phone = phoneController.text;
    final homeUniqueCode = homeUniqueCodeController.text;

    errorMessage = '';

    bool fieldIsEmpty = fullname.isEmpty ||
        nickname.isEmpty ||
        phone.isEmpty ||
        homeUniqueCode.isEmpty;

    if (!fieldIsEmpty && isTermsCheckedNotifier.value) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      addUserDetails(
        fullnameController.text,
        nicknameController.text,
        phoneController.text,
        homeUniqueCodeController.text,
        FirebaseAuth.instance.currentUser?.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });

      _formKey.currentState?.validate();
    }
  }

  Future<void> addUserDetails(
    String fullname,
    String nickname,
    String phone,
    String homeUniqueCode,
    String email,
  ) async {
    try {
      final users = FirebaseFirestore.instance.collection('users');
      final docRef = users.doc();
      docRef.set({
        'id': docRef.id,
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
                    text: const TextSpan(
                      style: TextStyle(
                        color: kAG2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Saya telah membaca dan menyetujui ',
                        ),
                        TextSpan(
                          text: 'Syarat dan Ketentuan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
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
                  onPressed: () {
                    createUserWithEmailAndPassword();
                    Navigator.pushNamed(context, SignUpSuccessfullScreen.id);
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
