import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class MembershipOrderSuccessfulScreen extends StatelessWidget {
  const MembershipOrderSuccessfulScreen({super.key});
  static String id = 'membership_order_successful_screen';

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
        backgroundColor: kLG3,
      ),
      backgroundColor: kLG3,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 240),
            const TopScreenImage(
              screenImageName: 'pengambilan_sampah_successful.png',
              width: 276.19,
              height: 240,
            ),
            const SizedBox(height: 59),
            Text(
              'Berhasil menambahkan membership',
              style: kH6.copyWith(
                color: kAG0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
