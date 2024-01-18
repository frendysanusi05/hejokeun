import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* Color */
// Basic Color
const Color kCornsilk = Color(0xFFFEFAE0);
const Color kCamel = Color(0xFFB99470);
const Color kBrown = Color(0xFF785432);
const Color kDarkBrown = Color(0xFF35210E);
const Color kLabel = Color(0xFF3C3C43);
const Color kDisabledBtn = Color(0xFF1D1B20);

// Aloe Green
const Color kAG0 = Color(0xFF404C37);
const Color kAG1 = Color(0xFF5F6F52);
const Color kAG2 = Color(0xFF818F76);
const Color kAG3 = Color(0xFFA3AF9A);
const Color kAG4 = Color(0xFFC5CEBE);
const Color kAG5 = Color(0xFFE7EEE2);

const Color kLG1 = Color(0xFFA9B388);
const Color kLG2 = Color(0xFFBEC6A4);
const Color kLG3 = Color(0xFFD3D9C0);
const Color kLG4 = Color(0xFFE8ECDC);
const Color kLG5 = Color(0xFFFDFFF8);

/* Custom Font */
TextStyle kBodyRegular = GoogleFonts.openSans().copyWith(
  fontWeight: regular,
);
TextStyle kBodySemiBold = GoogleFonts.openSans().copyWith(
  fontWeight: semiBold,
);
TextStyle kHeading = GoogleFonts.manrope().copyWith(
  fontWeight: bold,
);

/* Font Weight */
const regular = FontWeight.w400;
const semiBold = FontWeight.w600;
const bold = FontWeight.w700;

/* Font Size */
// Heading
TextStyle kH1 = kHeading.copyWith(
  fontSize: 64,
);
TextStyle kH2 = kHeading.copyWith(
  fontSize: 48,
);
TextStyle kH3 = kHeading.copyWith(
  fontSize: 32,
);
TextStyle kH4 = kHeading.copyWith(
  fontSize: 24,
);
TextStyle kH5 = kHeading.copyWith(
  fontSize: 20,
);
TextStyle kH6 = kHeading.copyWith(
  fontSize: 16,
);
TextStyle kH7 = kHeading.copyWith(
  fontSize: 14,
);

// Body-SemiBold
TextStyle kBS1 = kBodySemiBold.copyWith(
  fontSize: 20,
);
TextStyle kBS2 = kBodySemiBold.copyWith(
  fontSize: 16,
);
TextStyle kBS3 = kBodySemiBold.copyWith(
  fontSize: 14,
);
TextStyle kBS4 = kBodySemiBold.copyWith(
  fontSize: 12,
);
TextStyle kBS5 = kBodySemiBold.copyWith(
  fontSize: 10,
);

// Body-Regular
TextStyle kBR1 = kBodyRegular.copyWith(
  fontSize: 20,
);
TextStyle kBR2 = kBodyRegular.copyWith(
  fontSize: 16,
);
TextStyle kBR3 = kBodyRegular.copyWith(
  fontSize: 14,
);
TextStyle kBR4 = kBodyRegular.copyWith(
  fontSize: 12,
);
TextStyle kBR5 = kBodyRegular.copyWith(
  fontSize: 10,
);

/* Icons */
const IconData accessTime = IconData(0xe03a, fontFamily: 'MaterialIcons');
const IconData calendarMonthOutline =
    IconData(0xf051f, fontFamily: 'MaterialIcons');
const IconData error = IconData(0xe237, fontFamily: 'MaterialIcons');
const IconData sort =
    IconData(0xe5d2, fontFamily: 'MaterialIcons', matchTextDirection: true);
const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');
const IconData checkCircle = IconData(0xe159, fontFamily: 'MaterialIcons');
const IconData cameraAlt = IconData(0xe130, fontFamily: 'MaterialIcons');
const IconData arrowForwardIos =
    IconData(0xe09c, fontFamily: 'MaterialIcons', matchTextDirection: true);
