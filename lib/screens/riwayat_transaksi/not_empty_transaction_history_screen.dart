import 'package:flutter/material.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/transactions.dart';

class NotEmptyTransactionHistoryScreen extends StatelessWidget {
  const NotEmptyTransactionHistoryScreen({super.key});
  static String id = 'not_empty_transaction_screen';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/rupiah.png',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactions[index].type,
                                style: kBS3.copyWith(color: kDarkBrown),
                              ),
                              Text(
                                transactions[index].datetime,
                                style: kBR3.copyWith(color: kDarkBrown),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        transactions[index].point,
                        style: transactions[index].isGained
                            ? kBS2.copyWith(color: const Color(0xFF789713))
                            : kBS2.copyWith(color: kBrown),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey.shade100,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
