import 'package:flutter/material.dart';
import 'package:hejokeun/screens/riwayat_transaksi/empty_transaction_history_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/not_empty_transaction_history_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/transactions.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});
  static String id = 'transaction_history_screen';

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
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
                  const EdgeInsets.only(left: 24.0, top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Riwayat Terbaru',
                    style: kH5.copyWith(color: kDarkBrown),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 16.0),
                                      child: Text(
                                        'Pilih opsi filtering?',
                                        style: kBS2.copyWith(color: kDarkBrown),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 12.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, right: 6.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ToggleButtons(
                                            renderBorder: false,
                                            constraints: BoxConstraints.expand(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                            ),
                                            direction: Axis.vertical,
                                            isSelected: isSelected,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            onPressed: (int index) async {
                                              setState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] = i == index;
                                                }
                                              });
                                              await initializeTransactions();
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  TransactionHistoryScreen.id);
                                            },
                                            children: [
                                              Row(
                                                children: [
                                                  isSelected[0]
                                                      ? const Icon(
                                                          check,
                                                          color: kDarkBrown,
                                                          size: 24,
                                                        )
                                                      : const SizedBox(
                                                          width: 24),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Penjualan Sampah',
                                                    style: kBR2.copyWith(
                                                      color: kDarkBrown,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  isSelected[1]
                                                      ? const Icon(
                                                          check,
                                                          color: kDarkBrown,
                                                          size: 24,
                                                        )
                                                      : const SizedBox(
                                                          width: 24),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Pencairan Poin',
                                                    style: kBR2.copyWith(
                                                      color: kDarkBrown,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 80.0),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -50,
                                right: 16,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Icon(
                      sort,
                      color: kAG0,
                    ),
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
