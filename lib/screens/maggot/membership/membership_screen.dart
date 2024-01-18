import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/screens/maggot/membership/membership_order_successful_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'dart:math';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});
  static String id = 'membership_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.id);
          },
          color: kDarkBrown,
        ),
        backgroundColor: kLG3,
      ),
      backgroundColor: kLG3,
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(MediaQuery.of(context).size.height + 169, 812.0),
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(height: 18),
                  TopScreenImage(
                    screenImageName: 'membership.png',
                    width: 303,
                    height: 226.43,
                  ),
                ],
              ),
              Positioned(
                top: 346,
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/icons/custom_rectangle_1.png',
                  width: 375,
                  height: 466,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 414.3,
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dapatkan Layananmu Sekarang!',
                        style: kH5.copyWith(color: kDarkBrown),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Mendapatkan pemeliharaan magot  secara rutin dari perusahaannya',
                              style: kBR4.copyWith(color: kDarkBrown),
                            ),
                          ),
                          const Icon(
                            checkCircle,
                            color: kCamel,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Tersedia komunitas untuk mengembangkan maggot bersama',
                              style: kBR4.copyWith(color: kDarkBrown),
                            ),
                          ),
                          const Icon(
                            checkCircle,
                            color: kCamel,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      CustomButton(
                        buttonText: 'Rp75000/Bulan',
                        buttonColor: kAG1,
                        width: double.infinity,
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Center(
                                    child: Text('Apakah Anda yakin?')),
                                titleTextStyle:
                                    kBS2.copyWith(color: kDarkBrown),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Biaya langganan dapat dibatalkan kapan saja dan akan langsung masuk ke tagihan akhir Anda.',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Tagihan berikutnya: 10/02/2024',
                                        style: kBR5.copyWith(color: kDarkBrown),
                                      ),
                                      const SizedBox(height: 16),
                                      CustomButton(
                                        buttonText: 'Lanjutkan Pembayaran',
                                        buttonColor: kAG1,
                                        width: double.infinity,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              MembershipOrderSuccessfulScreen
                                                  .id);
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      CustomButton(
                                        buttonText: 'Batalkan',
                                        width: double.infinity,
                                        isOutlined: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pembayaran akan digabung ke dalam tagihan akhir bulan',
                        style: kBR5.copyWith(
                          color: const Color(0xFF3C3C43).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
