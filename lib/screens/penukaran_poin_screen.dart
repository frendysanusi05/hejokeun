import 'package:flutter/material.dart';
import 'package:hejokeun/utils/constants.dart';

class PenukaranPoinScreen extends StatefulWidget {
  const PenukaranPoinScreen({super.key});
  static String id = 'penukaran_poin_screen';

  @override
  State<PenukaranPoinScreen> createState() => _PenukaranPoinScreenState();
}

class _PenukaranPoinScreenState extends State<PenukaranPoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFA9B388),
            Color(0xFF606060),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: kAG1,
          ),
          title: Text(
            'Penukaran Poin',
            style: kH6.copyWith(
              color: kAG1,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 3),
                  Text(
                    'Jumlah Poin',
                    style: kH5.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/psychiatry.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '4000',
                            style: kH4.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Points',
                            style: kBS4.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 680,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
