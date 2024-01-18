import 'package:flutter/material.dart';
import 'package:hejokeun/model/penukaran.dart';
import 'package:hejokeun/provider/cart_provider.dart';
import 'package:hejokeun/screens/katalog_penukaran/detail_pengambilan_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/components/components.dart';
import 'package:provider/provider.dart';

class KatalogPenukaranScreen extends StatefulWidget {
  const KatalogPenukaranScreen({super.key});
  static String id = 'katalog_penukaran_screen';

  @override
  State<KatalogPenukaranScreen> createState() => _KatalogPenukaranScreenState();
}

class _KatalogPenukaranScreenState extends State<KatalogPenukaranScreen> {
  final List<String> tipe = [
    'Organik',
    'Botol',
    'Plastik',
    'Minyak Jelantah',
    'Elektronik',
    'Lainnya',
  ];
  final List<List<Penukaran>> penukaran = [
    // Organik
    [
      Penukaran(
          name: 'Sisa Makanan',
          description:
              'Segala jenis sisa makanan, seperti kulit buah yang membusuk atau potongan sayur yang tidak terpakai',
          type: 'Organik',
          image: 'sisa_makanan.png',
          point: 300),
      Penukaran(
          name: 'Kertas Sisa Makanan',
          description:
              'Segala jenis bungkus kertas yang sudah terkontaminasi makanan, seperti bungkus teh',
          type: 'Organik',
          image: 'kertas_sisa_makanan.png',
          point: 300),
      Penukaran(
          name: 'Sampah Perkebunan',
          description:
              'Termasuk sampah dedaunan atau ranting pohon yang tersisa saat membersihkan kebun rumah',
          type: 'Organik',
          image: 'sampah_perkebunan.png',
          point: 300),
    ],

    // Botol
    [
      Penukaran(
          name: 'Botol Plastik',
          description:
              'Termasuk segala jenis kemasan plastik tebal untuk makanan',
          type: 'Botol',
          image: 'botol_plastik.png',
          point: 300),
      Penukaran(
          name: 'Botol Kaca',
          description: 'Termasuk segala jenis kemasan kaca yang mudah pecah',
          type: 'Botol',
          image: 'botol_kaca.png',
          point: 300),
    ],

    // Plastik
    [
      Penukaran(
          name: 'Plastik Kresek',
          description:
              'Termasuk segala jenis bungkus plastik (warna hitam, merah, putih) serta plastik tipis',
          type: 'Plastik',
          image: 'plastik_kresek.png',
          point: 300),
    ],

    // Minyak Jelantah
    [
      Penukaran(
          name: 'Minyak Jelantah',
          description:
              'Segala jenis minyak bekas atau sisa dari menggoreng di rumah Anda',
          type: 'Minyak Jelantah',
          image: 'minyak_jelantah.png',
          point: 300),
    ],

    // Elektronik
    [
      Penukaran(
          name: 'Baterai',
          description:
              'Termasuk segala jenis baterai yang tidak dapat diisi ulang',
          type: 'Elektronik',
          image: 'baterai.png',
          point: 300),
    ],

    // Lainnya
    [
      Penukaran(
          name: 'Sampah Lainnya',
          description:
              'Segala jenis sampah yang belum ada dalam kategori katalog sampah',
          type: 'Lainnya',
          image: 'sampah_lainnya.png',
          point: 300),
    ],
  ];

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
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: penukaran.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tipe[index],
                              style: kBS2.copyWith(color: kDarkBrown),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8, top: 8),
                              child: DashedLineSeparator(),
                            ),
                            PenukaranList(listData: penukaran[index]),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      }),
                ),
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 15)
                      ]),
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 50,
                    child: Center(
                        child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, DetailPengambilanScreen.id);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kAG1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Item',
                                    style: kBR5.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    'Total Sampah',
                                    style: kBR5.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${value.getTotalItem()} items',
                                    style: kBS5.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    '${value.getTotalQuantity()} kg',
                                    style: kBS5.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${value.getTotalPoints()} poin',
                                style: kH7.copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const TopScreenImage(
                                screenImageName: 'psychiatry_inverse.png',
                                width: 24,
                                height: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
                )));
  }
}

class PenukaranList extends StatefulWidget {
  final List<Penukaran> listData;
  PenukaranList({required this.listData});

  @override
  State<PenukaranList> createState() => _PenukaranListState();
}

class _PenukaranListState extends State<PenukaranList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _textEditingController,
                        validator: (value) {
                          try {
                            double number = double.parse(value!);
                            if (number <= 0) {
                              return 'Please enter a positive number.';
                            }
                          } catch (e) {
                            return 'Please enter a valid number.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "0"),
                      ),
                    ],
                  )),
              title: const Text('Masukkan jumlah sampah'),
              actions: <Widget>[
                InkWell(
                  child: const Text('OK'),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // setState(() {});
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(
                        widget.listData[index],
                        double.parse(_textEditingController.text),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider value, Widget? child) =>
          ListView.builder(
              itemCount: widget.listData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  child: Row(
                    children: [
                      TopScreenImage(
                          screenImageName: widget.listData[index].image),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // height: 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listData[index].name,
                              style: kBS3,
                            ),
                            SizedBox(
                              width: 230,
                              child: Text(
                                widget.listData[index].description,
                                style: kBR5,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 15),
                                  decoration: const BoxDecoration(
                                      color: kAG5,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(children: [
                                    const TopScreenImage(
                                        screenImageName: 'psychiatry.png',
                                        width: 20,
                                        height: 20),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        '+ ${widget.listData[index].point} Poin',
                                        style: kBS4.copyWith(color: kAG0)),
                                  ]),
                                ),
                                const Spacer(),
                                OutlinedButton(
                                  onPressed: () async {
                                    await showInformationDialog(context, index);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2, left: 16, right: 16),
                                    side: const BorderSide(color: kAG1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  child: Text(
                                      '${value.getItemQuantity(widget.listData[index].name) == 0 ? 'Tambah' : value.getItemQuantity(widget.listData[index].name)}',
                                      style: kBS4.copyWith(color: kAG1)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
