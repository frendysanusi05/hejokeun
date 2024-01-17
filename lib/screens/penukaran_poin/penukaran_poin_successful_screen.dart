import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class PenukaranPoinSuccessfulScreen extends StatelessWidget {
  const PenukaranPoinSuccessfulScreen({super.key});
  static String id = 'penukaran_poin_successful_screen';

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
        backgroundColor: kLG1,
      ),
      backgroundColor: kLG1,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 240),
            const TopScreenImage(
              screenImageName: 'money_investment.png',
              width: 276.19,
              height: 240,
            ),
            const SizedBox(height: 59),
            Text(
              'Poinmu berhasil ditukarkan',
              style: kH6.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
