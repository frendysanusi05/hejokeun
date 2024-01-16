import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/home_screen.dart';
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
            Navigator.pushNamed(context, HomeScreen.id);
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
              screenImageName: 'pengambilan_sampah_successful.png',
              width: 276.19,
              height: 240,
            ),
            const SizedBox(height: 59),
            Text(
              'Request Pengambilan Sampah berhasil dilakukan',
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
