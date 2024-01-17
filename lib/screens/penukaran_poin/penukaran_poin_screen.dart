import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/screens/penukaran_poin/penukaran_poin_successful_screen.dart';

class PenukaranPoinScreen extends StatefulWidget {
  const PenukaranPoinScreen({super.key});
  static String id = 'penukaran_poin_screen';

  @override
  State<PenukaranPoinScreen> createState() => _PenukaranPoinScreenState();
}

class _PenukaranPoinScreenState extends State<PenukaranPoinScreen> {
  User? currentUser;
  late final DocumentReference usersReference;
  dynamic points;

  late final TextEditingController coinController;
  late final TextEditingController paymentController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  int _type = 0;

  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  void initializeControllers() {
    coinController = TextEditingController()..addListener(controllerListeners);
    paymentController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    coinController.dispose();
    paymentController.dispose();
  }

  void controllerListeners() {
    final coin = coinController.text;
    final payment = paymentController.text;

    bool fieldIsEmpty = coin.isEmpty || payment.isEmpty;

    if (!fieldIsEmpty && int.parse(coin) <= points) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<dynamic> getPoints() async {
    try {
      DocumentSnapshot pointSnapshot = await usersReference.get();
      if (pointSnapshot.exists) {
        setState(() {
          points = (pointSnapshot.data() as Map<String, dynamic>)['point'];
        });
        return points;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void updatePoints(int newPoints) {
    usersReference.update({
      'point': newPoints,
    });
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    usersReference =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    getPoints();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kLG1,
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                          points.toString(),
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
                const SizedBox(height: 24),
                Container(
                  height: MediaQuery.of(context).size.height - 190,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 33.83,
                            ),
                            Text(
                              'Jumlah Poin yang ingin ditukarkan',
                              style: kBS3.copyWith(
                                color: kAG0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: coinController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Masukkan jumlah koin',
                                labelStyle: kBR3.copyWith(
                                  color: kLabel,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: kAG2,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: kAG1,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                              style: kBR3.copyWith(
                                color: const Color(0xFF3C3C43).withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Setiap 200 Poin dapat ditukar menjadi Rp 1000',
                              style: kBR4.copyWith(
                                color: kAG0,
                              ),
                            ),
                            const SizedBox(height: 31),
                            Text(
                              'Kemana poin Anda ingin dikonversi?',
                              style: kBS3.copyWith(
                                color: kAG0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                PaymentMethod(
                                  value: 1,
                                  type: _type,
                                  handleRadio: _handleRadio,
                                  text: 'GoPay',
                                  asset: 'assets/images/gopay.png',
                                  showBorderRadius: true,
                                  controller: paymentController,
                                ),
                                PaymentMethod(
                                  value: 2,
                                  type: _type,
                                  handleRadio: _handleRadio,
                                  text: 'ShopeePay',
                                  asset: 'assets/images/shopeepay.png',
                                  showTopBorder: false,
                                  controller: paymentController,
                                ),
                                PaymentMethod(
                                  value: 3,
                                  type: _type,
                                  handleRadio: _handleRadio,
                                  text: 'DANA',
                                  asset: 'assets/images/dana.png',
                                  showTopBorder: false,
                                  controller: paymentController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),
                            ValueListenableBuilder(
                              valueListenable: fieldValidNotifier,
                              builder: (_, isValid, __) {
                                return _type == 0
                                    ? Container()
                                    : CustomButton(
                                        buttonText: 'Tukarkan Poin',
                                        buttonColor: kAG0,
                                        width: double.infinity,
                                        textColor: Colors.white,
                                        isDisabled: !isValid,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            )),
                                            builder: (BuildContext context) {
                                              return Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Apakah Anda yakin?',
                                                          style: kBS1.copyWith(
                                                              color:
                                                                  kDarkBrown),
                                                        ),
                                                        const SizedBox(
                                                            height: 16.0),
                                                        CustomButton(
                                                          buttonText:
                                                              'Ya, saya yakin',
                                                          buttonColor: kAG0,
                                                          textColor:
                                                              Colors.white,
                                                          isDisabled: !isValid,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          onPressed: () {
                                                            updatePoints(points -
                                                                int.parse(
                                                                    coinController
                                                                        .text));
                                                            Navigator.pushNamed(
                                                                context,
                                                                PenukaranPoinSuccessfulScreen
                                                                    .id);
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 16.0),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: -50,
                                                    right: 16,
                                                    child: Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close_rounded,
                                                        ),
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
