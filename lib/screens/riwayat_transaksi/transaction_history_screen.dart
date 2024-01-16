import 'package:flutter/material.dart';
import 'package:hejokeun/screens/riwayat_transaksi/empty_transaction_history_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/not_empty_transaction_history_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/transactions.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});
  static String id = 'transaction_history_screen';

  @override
  Widget build(BuildContext context) {
    List<Transactions> transactions = getTransactions();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Riwayat Terbaru',
                    style: kH5.copyWith(color: kDarkBrown),
                  ),
                  const Icon(
                    sort,
                    color: kAG0,
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            transactions.isEmpty
                ? const EmptyTransactionHistoryScreen()
                : const NotEmptyTransactionHistoryScreen(),
          ],
        ),
      ),
    );
  }
}
