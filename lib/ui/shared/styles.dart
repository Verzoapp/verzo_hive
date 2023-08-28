import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color kcPrimaryColor = Color(0xff027DFF);
const Color kcButtonTextColor = Colors.white;
const Color kcTextColor = Color(0xff141414);
Color kcTextFormColor = const Color(0xff141414).withOpacity(0.5);
const Color kcTextColorLight = Color(0xff888888);
Color kcStrokeColor = const Color(0xffABB3BF).withOpacity(0.5);
Color kcFillColor = const Color(0xffD3D3D3).withOpacity(0.2);

// Radius
OutlineInputBorder defaultFormBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide:
        BorderSide(width: 0.7, style: BorderStyle.solid, color: kcStrokeColor));

OutlineInputBorder defaultFocusedFormBorder = OutlineInputBorder(
  // Highlighted border when focused
  borderRadius: defaultBorderRadius,
  borderSide: const BorderSide(
      width: 1, // Adjust the width to control the border thickness
      color: kcPrimaryColor,
      style: BorderStyle.solid // Highlight color
      ),
);

OutlineInputBorder defaultFormBorderSmall = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
        width: 0.01, style: BorderStyle.solid, color: kcStrokeColor));
BorderRadius defaultBorderRadius = BorderRadius.circular(12);

BorderRadius defaultTagBorderRadius = BorderRadius.circular(20);

BorderRadius defaultCarouselBorderRadius = BorderRadius.circular(32);

// TextStyle
TextStyle ktsHeroText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kHeroTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsHeroTextWhite = GoogleFonts.dmSans(
  color: kcButtonTextColor,
  fontSize: kHeroTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsHeaderText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kHeaderTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsHeaderTextWhite = GoogleFonts.dmSans(
  color: kcButtonTextColor,
  fontSize: kHeaderTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsTitleText = GoogleFonts.dmSans(
  color: kcTextColor, //1
  fontSize: kTitleTextSize,
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
TextStyle ktsButtonTextBlue = GoogleFonts.dmSans(
  color: kcPrimaryColor,
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);
TextStyle ktsButtonTextSmall = GoogleFonts.dmSans(
  color: kcButtonTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsBodyText = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.normal,
);
TextStyle ktsBodyTextx = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.w400,
);

TextStyle ktsBodyTextBold = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.bold,
);
TextStyle ktsBodyTextBoldOpaque = GoogleFonts.dmSans(
  color: kcTextColor.withOpacity(0.8),
  fontSize: kBodyTextSize,
  fontWeight: FontWeight.bold,
);

TextStyle ktsBodyText2 = GoogleFonts.dmSans(
  color: kcTextColor,
  fontSize: kParagraphTextSize,
  fontWeight: FontWeight.normal,
);

TextStyle ktsFormText = GoogleFonts.dmSans(
  color: kcTextFormColor, //2
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
TextStyle ktsforgotpasswordText = GoogleFonts.dmSans(
  color: kcPrimaryColor, //4
  fontSize: kSmallBodyTextSize,
  fontWeight: FontWeight.normal,
);
// Font Sizing
const double kSmallBodyTextSize = 12;
const double kBodyTextSize = 14;
const double kParagraphTextSize = 16;
const double kTitleTextSize = 18;
const double kHeaderTextSize = 20;
const double kHeroTextSize = 32;
