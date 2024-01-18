import 'package:flutter/material.dart';
import 'package:hejokeun/auth.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/components/navbar.dart';
import 'package:hejokeun/screens/welcome_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await initializeProfile();
    });

    return Scaffold(
      backgroundColor: kLG3,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 508.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/custom_rectangle_5.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            bottom: MediaQuery.of(context).size.height - 178,
            left: 0,
            right: 0,
            child: Container(
              height: 166,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/custom_rectangle_2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 24,
            bottom: MediaQuery.of(context).size.height - 107,
            left: 0,
            right: 0,
            child: Container(
              height: 83,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/custom_rectangle_4.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: -12.5,
            bottom: MediaQuery.of(context).size.height - 70,
            left: 0,
            right: 0,
            child: Container(
              height: 82.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/custom_rectangle_3.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/profile.png',
                          width: 73,
                          height: 73,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            cameraAlt,
                            color: kDarkBrown,
                            size: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 223,
            left: 24,
            right: 24,
            child: Container(
              height: 424,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Akun Saya',
                      style: kH7.copyWith(color: kAG1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Lengkap',
                            style: kBS4.copyWith(
                              color: const Color(0xFF3C3C43).withOpacity(0.6),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.fullname,
                                style: kBR3.copyWith(
                                  color: kDarkBrown,
                                ),
                              ),
                              const Icon(
                                arrowForwardIos,
                                color: kDarkBrown,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail',
                            style: kBS4.copyWith(
                              color: const Color(0xFF3C3C43).withOpacity(0.6),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.email,
                                style: kBR3.copyWith(
                                  color: kDarkBrown,
                                ),
                              ),
                              const Icon(
                                arrowForwardIos,
                                color: kDarkBrown,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Telepon',
                            style: kBS4.copyWith(
                              color: const Color(0xFF3C3C43).withOpacity(0.6),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.phone,
                                style: kBR3.copyWith(
                                  color: kDarkBrown,
                                ),
                              ),
                              const Icon(
                                arrowForwardIos,
                                color: kDarkBrown,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.homeUniqueCode,
                            style: kBS4.copyWith(
                              color: const Color(0xFF3C3C43).withOpacity(0.6),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'R0001',
                                style: kBR3.copyWith(
                                  color: kDarkBrown,
                                ),
                              ),
                              const Icon(
                                arrowForwardIos,
                                color: kDarkBrown,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Lainnya',
                        style: kH7.copyWith(color: kAG1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ubah Kata Sandi',
                            style: kBS3.copyWith(
                              color: kDarkBrown,
                            ),
                          ),
                          const Icon(
                            arrowForwardIos,
                            color: kDarkBrown,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
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
                                  padding: const EdgeInsets.all(16.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Apakah Anda yakin?',
                                        style: kBS1.copyWith(color: kDarkBrown),
                                      ),
                                      const SizedBox(height: 16.0),
                                      CustomButton(
                                        buttonText: 'Ya, saya yakin',
                                        buttonColor: kAG0,
                                        textColor: Colors.white,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        onPressed: () async {
                                          await Auth().signOut();
                                          Navigator.pushNamed(
                                              context, WelcomeScreen.id);
                                        },
                                      ),
                                      const SizedBox(height: 16.0),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Log Out',
                              style: kBS3.copyWith(
                                color: kDarkBrown,
                              ),
                            ),
                            const Icon(
                              arrowForwardIos,
                              color: kDarkBrown,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 3,
      ),
    );
  }
}
