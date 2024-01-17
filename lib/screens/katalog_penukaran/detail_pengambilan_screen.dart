import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/provider/cart_provider.dart';
import 'package:hejokeun/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/components/components.dart';

class DetailPengambilanScreen extends StatefulWidget {
  const DetailPengambilanScreen({super.key});
  static String id = 'detail_pengambilan_screen';

  @override
  State<DetailPengambilanScreen> createState() =>
      _DetailPengambilanScreenState();
}

class _DetailPengambilanScreenState extends State<DetailPengambilanScreen> {
  User? currentUser;
  late final DocumentReference usersReference;
  late final CollectionReference transactionsReference;
  late final CollectionReference historyReference;
  dynamic alamat;
  dynamic points;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    usersReference =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    getPoints();
    transactionsReference =
        FirebaseFirestore.instance.collection('transactions');
    historyReference = FirebaseFirestore.instance.collection('history');
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

  Future<void> addTransaction(int pointGained) {
    return transactionsReference.add({
      'isGained': true,
      'point': pointGained,
      'time': DateTime.now(),
      'user_id': currentUser!.uid,
    });
  }

  Future<void> addHistory(String name, String type, double quantity) {
    return historyReference.add({
      'name': name,
      'type': type,
      'quantity': quantity,
      'created_at': DateTime.now(),
      'user_id': currentUser!.uid,
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider value, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: kAG1,
            // Onpressed must go back
          ),
          title: Text(
            'Detail Pengambilan',
            style: kH6.copyWith(color: kAG1),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 75,
          padding: const EdgeInsets.all(16.0),
          child: FilledButton(
            onPressed: () {
              // Update points
              usersReference.update({
                'point': points + value.getTotalPoints(),
              });

              // Add transaction
              addTransaction(value.getTotalPoints());

              // Add history
              for (var element in value.cartItems) {
                addHistory(
                    element.penukaran.name, 'penukaran', element.quantity);
              }

              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.id, (route) => false);
            },
            style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: kAG1),
            child: Center(
                child: Text(
              "Ajukan Permintaan",
              style: kBS3,
            )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Alamat Pengambilan',
                            style: kBS4.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Perumahan Irenk 17 Blok F No 5, Depok Timur",
                        style: kH6.copyWith(color: Colors.black),
                      )
                    ]),
              ),
              Container(
                color: Colors.grey[200],
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getTotalItem(),
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.cartItems[index].penukaran.name,
                              style: kBS3.copyWith(color: kDarkBrown),
                            ),
                            TopScreenImage(
                                screenImageName:
                                    value.cartItems[index].penukaran.image)
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const TopScreenImage(
                                screenImageName: "psychiatry.png",
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '+ ${value.cartItems[index].penukaran.point.toString()} Poin',
                                style: kBS4.copyWith(color: kAG0),
                              ),
                            ]),
                            OutlinedButton(
                              onPressed: () async {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    top: 2, bottom: 2, left: 16, right: 16),
                                side: const BorderSide(color: kAG1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text(
                                  '${value.cartItems[index].quantity.toString()} kg',
                                  style: kH7.copyWith(color: kAG1)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          color: Colors.grey[200],
                          height: 10,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request Pick Up Summary',
                        style: kBS3.copyWith(color: kAG0),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Item',
                            style: kBR4.copyWith(color: kDarkBrown),
                          ),
                          Text(
                            '${value.getTotalItem()} items',
                            style: kBR4.copyWith(color: kDarkBrown),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Weight',
                            style: kBR4.copyWith(color: kDarkBrown),
                          ),
                          Text(
                            '${value.getTotalQuantity()} kg',
                            style: kBR4.copyWith(color: kDarkBrown),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey[200],
                        height: 10,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Point',
                            style: kBS3.copyWith(color: kDarkBrown),
                          ),
                          Text(
                            '${value.getTotalPoints()} Poin',
                            style: kBS3.copyWith(color: kDarkBrown),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
