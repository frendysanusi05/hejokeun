import 'package:flutter/material.dart';
import 'package:hejokeun/screens/maggot/maggot_indonesia_screen.dart';
import 'package:hejokeun/screens/maggot/membership/membership_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class AboutMaggotScreen extends StatelessWidget {
  const AboutMaggotScreen({super.key});
  static String id = 'about_maggot_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'About Maggot',
          style: kH6.copyWith(color: kLG3),
        ),
        leading: const BackButton(
          color: kLG3,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 821,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 355,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/about_maggot.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 249.0,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 249,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apa Itu Maggot?',
                          style: kH6.copyWith(
                            color: kDarkBrown,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Maggot merupakan larva yang berada dalam tahap perkembangan awal dari serangga yang mengalami metamorfosis sempurna. Maggot adalah agen pengurai yang efektif, berperan dalam mengurai materi organik yang sudah mati, seperti sisa-sisa makanan manusia. Maggot juga memiliki peran penting sebagai alternatif pakan yang kaya nutrisi untuk ternak. Maggot tidak hanya membantu mengelola limbah organik, tetapi juga menghasilkan produk sampingan berupa pupa yang dapat dimanfaatkan dalam industri pakan ternak. Selain itu, budidaya maggot dapat menjadi solusi untuk mengurangi dampak lingkungan dari limbah organik.',
                          style: kBR5.copyWith(
                            color: kDarkBrown,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MembershipScreen.id);
                          },
                          child: SizedBox(
                            height: 152,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/maggot_membership.png',
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                ),
                                Positioned(
                                  top: 0.0,
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Maggot\nMembership',
                                          style:
                                              kH6.copyWith(color: kDarkBrown),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Dapatkan layanan\npemeliharaan intensif\nuntuk maggot Anda!',
                                          style: kBS5.copyWith(color: kAG0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Perusahaan Maggot',
                          style: kH6.copyWith(color: kDarkBrown),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MaggotIndonesiaScreen.id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/maggot_indonesia_lestari.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          'Maggot\nIndonesia\nLestari',
                                          style: kH6.copyWith(
                                            color: kDarkBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/biomagg.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          'Biomagg',
                                          style: kH6.copyWith(
                                            color: kDarkBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
