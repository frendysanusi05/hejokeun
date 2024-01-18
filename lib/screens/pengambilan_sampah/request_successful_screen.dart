import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class RequestSuccessfulScreen extends StatelessWidget {
  const RequestSuccessfulScreen({super.key});
  static String id = 'request_successful_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kembali ke Menu Utama',
          style: kH6.copyWith(color: kAG1),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.id);
          },
        ),
        backgroundColor: kLG2,
      ),
      backgroundColor: kLG2,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 240),
            const TopScreenImage(
              screenImageName: 'request_successful.png',
              width: 240.41,
              height: 270,
            ),
            const SizedBox(height: 48),
            Text(
              'Berhasil mengajukan request',
              style: kH6.copyWith(
                color: kAG0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
