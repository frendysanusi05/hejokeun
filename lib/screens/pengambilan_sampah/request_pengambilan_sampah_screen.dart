import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/screens/pengambilan_sampah/pengambilan_sampah_successful_screen.dart';
import 'package:hejokeun/utils/constants.dart';
import 'package:hejokeun/utils/schedule_events.dart';

class RequestPengambilanSampahScreen extends StatefulWidget {
  const RequestPengambilanSampahScreen({super.key});
  static String id = 'request_pengambilan_sampah_screen';

  @override
  State<RequestPengambilanSampahScreen> createState() =>
      _RequestPengambilanSampahScreenState();
}

class _RequestPengambilanSampahScreenState
    extends State<RequestPengambilanSampahScreen> {
  String? errorMessage = '';

  late final TextEditingController dateController;
  late final TextEditingController timeController;
  late final TextEditingController isTermsCheckedController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isTermsCheckedNotifier = ValueNotifier<bool>(false);

  DateTime temp = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<void> sendPickupRequest(
    String type,
    String date,
    String time,
  ) async {
    try {
      final pickupSchedule =
          FirebaseFirestore.instance.collection('pickup_schedule');
      final docRef = pickupSchedule.doc();

      DateTime datetime = parseDateAndTime(date, time);

      docRef.set({
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'time': datetime,
        'type': type, // dummy data
      });
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void initializeControllers() {
    dateController = TextEditingController()..addListener(controllerListeners);
    timeController = TextEditingController()..addListener(controllerListeners);
    isTermsCheckedController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    dateController.dispose();
    timeController.dispose();
    isTermsCheckedController.dispose();
  }

  void controllerListeners() {
    final date = dateController.text;
    final time = timeController.text;

    bool fieldIsEmpty = date.isEmpty || time.isEmpty;

    if (!fieldIsEmpty && isTermsCheckedNotifier.value) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Pengambilan Sampah',
          style: kH6.copyWith(color: kAG1),
        ),
        leading: const BackButton(
          color: kAG1,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Text(
                'Pilih tanggal pengambilan sampah',
                style: kBS3.copyWith(color: kAG0),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());

                  date = await showDatePicker(
                      context: context,
                      initialDate: temp,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  if (date != null) {
                    temp = date;
                  }

                  if (date == null && dateController.text.isEmpty) {
                    return;
                  }

                  date ??= temp;

                  String month = date.month.toString();
                  if (month.length == 1) {
                    month = '0$month';
                  }

                  dateController.text = '${date.day}/$month/${date.year}';
                },
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  labelStyle: kBR3.copyWith(
                    color: kLabel,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: kAG2,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: kAG1,
                      width: 1.2,
                    ),
                  ),
                  prefixIcon: const Icon(
                    calendarMonthOutline,
                    color: kAG0,
                  ),
                ),
                style: kBR3.copyWith(
                  color: const Color(0xFF3C3C43).withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Pilih jam pengambilan sampah',
                style: kBS3.copyWith(color: kAG0),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: timeController,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  TimeOfDay? picked =
                      await showTimePicker(context: context, initialTime: time);

                  if (picked == null && timeController.text.isEmpty) {
                    return;
                  }

                  picked ??= time;
                  time = picked;

                  String hour = picked.hour.toString();
                  String minute = picked.minute.toString();

                  if (hour.length == 1) {
                    hour = '0$hour';
                  }
                  if (minute.length == 1) {
                    minute = '0$minute';
                  }

                  timeController.text = '$hour.$minute WIB';
                },
                decoration: InputDecoration(
                  hintText: 'Format 24 Jam',
                  labelStyle: kBR3.copyWith(
                    color: kLabel,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: kAG2,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: kAG1,
                      width: 1.2,
                    ),
                  ),
                  prefixIcon: const Icon(
                    accessTime,
                    color: kAG0,
                  ),
                ),
                style: kBR3.copyWith(
                  color: const Color(0xFF3C3C43).withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Batas waktu pengambilan sampah : 07.00-15.00 WIB',
                style: kBR4.copyWith(color: kAG0),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(8),
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kLG1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      error,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        'Akan ada biaya tambahan untuk melakukan request pengambilan di luar jadwal',
                        style: kBS5.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    activeColor: kAG1,
                    value: isTermsCheckedNotifier.value,
                    onChanged: (value) {
                      setState(() {
                        isTermsCheckedNotifier.value = value!;
                        isTermsCheckedController.text = value.toString();
                      });
                    },
                  ),
                  Text(
                    'Ya, saya tetap ingin melakukan request pengambilan sampah',
                    style: kBR5.copyWith(color: kAG2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: fieldValidNotifier,
                builder: (_, isValid, __) {
                  return CustomButton(
                      buttonText: 'Ajukan Permintaan',
                      buttonColor: kAG1,
                      textColor: Colors.white,
                      isDisabled: !isValid,
                      width: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        await sendPickupRequest('organik', dateController.text,
                            timeController.text);
                        await initializePickupScheduleData();
                        Navigator.pushNamed(
                            context, PengambilanSampahSuccessfulScreen.id);
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
