import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/artikel/artikel_screen.dart';
import 'package:hejokeun/utils/constants.dart';

class ArtikelHomeScreen extends StatefulWidget {
  const ArtikelHomeScreen({super.key});
  static String id = 'artikel_home_screen';

  @override
  State<ArtikelHomeScreen> createState() => _ArtikelHomeScreenState();
}

class _ArtikelHomeScreenState extends State<ArtikelHomeScreen> {
  dynamic _artikel;
  dynamic images;

  @override
  void initState() {
    super.initState();

    () async {
      QuerySnapshot<Object?> res =
          await FirebaseFirestore.instance.collection('news').limit(5).get();
      setState(() {
        _artikel = res.docs;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Artikel'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.network(
                _artikel[0]['image_url'],
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 200,
                  child: Card(
                    surfaceTintColor: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(_artikel[0]['title'],
                                  style: kBS3.copyWith(color: kDarkBrown)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _artikel[0]['published_date'],
                                    style: kBR4.copyWith(color: kBrown),
                                  ),
                                  const Icon(Icons.share_outlined)
                                ],
                              )
                            ],
                          )),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 100),
          Text(
            'Artikel Untukmu',
            style: kBS2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _artikel.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ArtikelScreen.id,
                                arguments: _artikel[index]);
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: Container(
                            width: 180,
                            height: 300,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    _artikel[index]['image_url'],
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        const TopScreenImage(
                                          screenImageName: "psychiatry.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _artikel[index]['author'],
                                          style:
                                              kBR4.copyWith(color: kDarkBrown),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _artikel[index]['title'],
                                      style: kBS3.copyWith(color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ]),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
