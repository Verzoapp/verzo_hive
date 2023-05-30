import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color kcPrimaryColor = Color(0xff029EFF);
const Color kcButtonTextColor = Colors.white;
const Color kcTextColor = Color(0xff141414);
const Color kcTextColorLight = Color(0xff888888);
Color kcStrokeColor = const Color(0xffABB3BF).withOpacity(0.5);

// Radius
OutlineInputBorder defaultFormBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide:
        BorderSide(width: 0.5, style: BorderStyle.solid, color: kcStrokeColor));

OutlineInputBorder defaultFormBorderSmall = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
        width: 0.01, style: BorderStyle.solid, color: kcStrokeColor));
BorderRadius defaultBorderRadius = BorderRadius.circular(6);

BorderRadius defaultTagBorderRadius = BorderRadius.circular(20);

BorderRadius defaultCarouselBorderRadius = BorderRadius.circular(32);

// TextStyle
TextStyle ktsHeroText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kHeroTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsHeaderText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kHeaderTextSize,
  fontWeight: FontWeight.bold,
);

TextStyle ktsParagraphText = GoogleFonts.dmSans(
  color: kcTextColorLight, //1
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);
TextStyle ktsButtonText = GoogleFonts.dmSans(
  color: kcButtonTextColor,
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsBodyText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsBodyTextBold = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.bold,
);

TextStyle ktsBodyText2 = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsFormText = GoogleFonts.dmSans(
  color: kcTextColorLight, //2
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsBodyTextLight = GoogleFonts.dmSans(
  color: kcTextColorLight, //3
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.normal,
);
TextStyle ktsSmallBodyText = GoogleFonts.dmSans(
  color: kcTextColorLight, //4
  fontSize: kSmallBodyTextSize,
  fontWeight: FontWeight.normal,
);
// Font Sizing
const double kSmallBodyTextSize = 12;
const double kBodyTextSize = 14;
const double kParagraphTextSize = 16;
const double kHeaderTextSize = 20;
const double kHeroTextSize = 32;
