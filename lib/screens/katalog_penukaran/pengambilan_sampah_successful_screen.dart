import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class PengambilanSampahSuccessfulScreen extends StatelessWidget {
  const PengambilanSampahSuccessfulScreen({super.key});
  static String id = 'pengambilan_sampah_successful_screen';

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
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            TopScreenImage(
              screenImageName: 'pengambilan_sampah_successful.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 48),
            Text(
              'Request Pengambilan Sampah\nberhasil dilakukan',
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
