import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            const TopScreenImage(
              screenImageName: 'main_backdrop.png',
            ),
            Positioned(
                top: 90,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hai, Hejoers!',
                        style: kH5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 8),
                    Card(
                      surfaceTintColor: Colors.white,
                      child: SizedBox(
                          width: 300,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    const TopScreenImage(
                                      screenImageName: "psychiatry.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("Jumlah Poin",
                                        style: kBS3.copyWith(
                                            color: kAG0,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const Spacer(),
                                const Text("4000 Poin")
                              ],
                            ),
                          )),
                    ),
                  ],
                ))
          ],
        ),
        const SizedBox(height: 60),
        Expanded(
          child: GridView.count(
              childAspectRatio: (1 / 1.5),
              padding: const EdgeInsets.only(left: 20, right: 20),
              crossAxisCount: 4,
              children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, 'katalog_penukaran_screen');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child:
                          const Icon(Icons.format_list_bulleted, color: kAG1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Katalog Penukaran",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child: const Text("Rp",
                          style: TextStyle(
                              color: kAG1, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Tukar Poin",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child: const Icon(Icons.campaign, color: kAG1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Zero Waste Campaign",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child: const Icon(Icons.bar_chart_rounded, color: kAG1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Statistik Kontribusi",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child: const Icon(Icons.bug_report, color: kAG1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("About Maggot",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kLG4,
                          foregroundColor: kLG5,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          fixedSize: const Size(50, 50)),
                      child: const Icon(Icons.receipt_long, color: kAG1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Biaya\nLayanan",
                        textAlign: TextAlign.center,
                        style: kBR4.copyWith(
                          color: kAG1,
                        )),
                  ],
                ),
              ]),
        ),
      ],
    );
  }
}
