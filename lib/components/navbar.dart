import 'package:flutter/material.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:hejokeun/screens/pengambilan_sampah/pengambilan_sampah_screen.dart';
import 'package:hejokeun/screens/profile/profile_screen.dart';
import 'package:hejokeun/screens/riwayat_transaksi/transaction_history_screen.dart';
import 'package:hejokeun/utils/constants.dart';

final List<String> _pages = <String>[
  MainScreen.id,
  PengambilanSampahScreen.id,
  TransactionHistoryScreen.id,
  ProfileScreen.id,
];

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.currentIndex});
  final currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 100,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: kBrown,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Jadwal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun Saya',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (int index) {
        Navigator.pushNamed(context, _pages[index]);
      },
    );
  }
}
