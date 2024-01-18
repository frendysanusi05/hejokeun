import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/riwayat_transaksi/transaction_history_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class EmptyTransactionHistoryScreen extends StatelessWidget {
  const EmptyTransactionHistoryScreen({super.key});
  static String id = 'empty_transaction_screen';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        const TopScreenImage(
          screenImageName: '404.png',
          width: 240.8,
          height: 160,
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: 240.8,
          child: Text(
            'Maaf, Anda belum memiliki riwayat apapun',
            style: kBS2.copyWith(
              color: kDarkBrown,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, TransactionHistoryScreen.id);
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          child: Text(
            'Refresh',
            style: kBS3.copyWith(
              color: kAG1,
            ),
          ),
        ),
      ],
    );
  }
}
