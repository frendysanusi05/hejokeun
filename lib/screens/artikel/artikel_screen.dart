import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/utils/constants.dart';

class ArtikelScreen extends StatelessWidget {
  const ArtikelScreen({super.key});
  static String id = 'artikel_screen';

  @override
  Widget build(BuildContext context) {
    final dynamic artikel = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Artikel'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 16),
                  child: Column(
                    children: [
                      Text(
                        artikel['title'],
                        style: kH5.copyWith(color: kDarkBrown),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const TopScreenImage(
                                screenImageName: "psychiatry.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(artikel['author'],
                                  style: kBR3.copyWith(color: kDarkBrown)),
                            ],
                          ),
                          const Icon(Icons.share_outlined)
                        ],
                      ),
                    ],
                  )),
              Image.network(
                artikel['image_url'],
                height: 240,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 8, bottom: 16),
                child: Text(
                  artikel['content'],
                  style: kBR2.copyWith(color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ));
  }
}
