import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatistikScreen extends StatefulWidget {
  const StatistikScreen({super.key});
  static String id = 'statistik_screen';

  @override
  State<StatistikScreen> createState() => _StatistikScreenState();
}

class _StatistikScreenState extends State<StatistikScreen> {
  User? currentUser;
  late final CollectionReference historyReference;
  late List<StatistikData> _chartData;
  dynamic historyData;
  late QuerySnapshot historySnapshot;
  num totalDonasi = 0;
  num totalOrganik = 0;
  num totalBotol = 0;
  num totalPlastik = 0;
  num totalMinyakJelantah = 0;
  num totalElektronik = 0;
  num totalLainnya = 0;

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des '
  ];
  List<String> monthsFull = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  Timestamp todayTimestamp = Timestamp.now();
  Timestamp lastWeekTimestamp =
      Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7)));

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    historyReference = FirebaseFirestore.instance.collection('history');

    () async {
      QuerySnapshot<Object?> res = await historyReference
          .where('user_id', isEqualTo: currentUser!.uid)
          .where('created_at', isGreaterThanOrEqualTo: lastWeekTimestamp)
          .where('created_at', isLessThanOrEqualTo: todayTimestamp)
          .get();
      setState(() {
        historyData = res.docs;
        _chartData = createChartData();
        totalOrganik = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.organik;
        });
        totalBotol = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.botol;
        });
        totalPlastik = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.plastik;
        });
        totalMinyakJelantah = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.minyakJelantah;
        });
        totalElektronik = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.elektronik;
        });
        totalLainnya = _chartData.fold(0, (previousValue, element) {
          return previousValue + element.lainnya;
        });
        totalDonasi = totalOrganik +
            totalBotol +
            totalPlastik +
            totalMinyakJelantah +
            totalElektronik +
            totalLainnya;
      });
    }();
  }

  List<StatistikData> createChartData() {
    List<StatistikData> chartData = [];
    for (var i = 1; i <= 7; i++) {
      DateTime dateTimestamp =
          lastWeekTimestamp.toDate().add(Duration(days: i));
      String date = '${dateTimestamp.day} ${months[dateTimestamp.month - 1]}';
      num organik = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Organik';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      num botol = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Botol';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      num plastik = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Plastik';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      num minyakJelantah = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Minyak Jelantah';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      num elektronik = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Elektronik';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      num lainnya = historyData
          .where((element) {
            DateTime elementDate = element.data()['created_at'].toDate();
            return elementDate.day == dateTimestamp.day &&
                elementDate.month == dateTimestamp.month &&
                element.data()['type'] == 'Lainnya';
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.data()['quantity'];
          });
      chartData.add(StatistikData(
          date: date,
          organik: organik,
          botol: botol,
          plastik: plastik,
          minyakJelantah: minyakJelantah,
          elektronik: elektronik,
          lainnya: lainnya));
    }

    return chartData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Statistik'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_backdrop.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 80,
            child: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 32, right: 32),
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          Text(
                            "${lastWeekTimestamp.toDate().day} ${monthsFull[lastWeekTimestamp.toDate().month - 1]} ${lastWeekTimestamp.toDate().year} - ${todayTimestamp.toDate().day} ${monthsFull[todayTimestamp.toDate().month - 1]} ${todayTimestamp.toDate().year}",
                            style: kBR3.copyWith(color: kDarkBrown),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '${(totalDonasi / 8).toStringAsFixed(2)}',
                                style: kH5.copyWith(color: kDarkBrown),
                              ),
                              Text(
                                ' kg sampah/hari',
                                style: kH7.copyWith(color: kDarkBrown),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: SfCartesianChart(
                              primaryXAxis: const CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                  numberFormat: NumberFormat.compact()),
                              legend: Legend(
                                  height: '50%',
                                  itemPadding: 8,
                                  alignment: ChartAlignment.center,
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  legendItemBuilder: (String name,
                                      dynamic series,
                                      dynamic point,
                                      int index) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 4, bottom: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: series.color,
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              name,
                                              style: kBR4.copyWith(
                                                  color: kDarkBrown),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              margin: EdgeInsets.all(0),
                              series: <CartesianSeries>[
                                StackedColumnSeries<StatistikData, String>(
                                  color:
                                      const Color.fromRGBO(100, 165, 185, 100),
                                  name: 'Organik',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.organik,
                                ),
                                StackedColumnSeries<StatistikData, String>(
                                  color:
                                      const Color.fromRGBO(243, 223, 96, 100),
                                  name: 'Botol',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.botol,
                                ),
                                StackedColumnSeries<StatistikData, String>(
                                  color: kBrown,
                                  name: 'Elektronik',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.elektronik,
                                ),
                                StackedColumnSeries<StatistikData, String>(
                                  color:
                                      const Color.fromRGBO(227, 116, 118, 100),
                                  name: 'Lainnya',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.lainnya,
                                ),
                                StackedColumnSeries<StatistikData, String>(
                                  color:
                                      const Color.fromRGBO(178, 210, 74, 100),
                                  name: 'Minyak Jelantah',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.minyakJelantah,
                                ),
                                StackedColumnSeries<StatistikData, String>(
                                  color:
                                      const Color.fromRGBO(255, 203, 153, 100),
                                  name: 'Plastik',
                                  dataSource: _chartData,
                                  xValueMapper: (StatistikData data, _) =>
                                      data.date,
                                  yValueMapper: (StatistikData data, _) =>
                                      data.plastik,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(60, 60, 67, 20),
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jumlah Donasi',
                                    style: kBS3.copyWith(color: kDarkBrown),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sampah Organik',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalOrganik}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sampah Botol',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalBotol}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sampah Plastik',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalPlastik}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Minyak Jelantah',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalMinyakJelantah}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sampah Elektronik',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalElektronik}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sampah Lainnya',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalLainnya}',
                                        style: kBR4.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Donasi',
                                        style: kBS3.copyWith(color: kDarkBrown),
                                      ),
                                      Text(
                                        '${totalDonasi}',
                                        style: kBS3.copyWith(color: kDarkBrown),
                                      )
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class StatistikData {
  StatistikData(
      {required this.date,
      required this.organik,
      required this.botol,
      required this.plastik,
      required this.minyakJelantah,
      required this.elektronik,
      required this.lainnya});

  final String date;
  final num organik;
  final num botol;
  final num plastik;
  final num minyakJelantah;
  final num elektronik;
  final num lainnya;
}
