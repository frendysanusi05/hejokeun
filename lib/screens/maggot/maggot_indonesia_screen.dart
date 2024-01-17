import 'package:flutter/material.dart';
import 'package:hejokeun/utils/constants.dart';

class MaggotIndonesiaScreen extends StatelessWidget {
  const MaggotIndonesiaScreen({super.key});
  static String id = 'maggot_indonesia_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: kLG3,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: 275,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/maggot_company.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PT Maggot Indonesia',
                  style: kH6.copyWith(color: kBrown),
                ),
                const SizedBox(height: 8),
                Text(
                  'Maggot Indonesia Lestari fokus pada pemanfaatan sampah organik sebagai bahan baku/pakan larva/maggot/belatung LALAT HITAM (Black Soldier Fly) untuk menghasilkan Protein, Nutrisi, Asam Amino, dan kandungan lain yang baik untuk pakan ternak. Sekaligus menghasilkan Pupuk Organik (frass/kasgot) yang kaya unsur hara.',
                  style: kBR5.copyWith(color: kDarkBrown),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
