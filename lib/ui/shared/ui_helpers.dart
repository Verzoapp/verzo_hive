import 'package:flutter/material.dart';

// Horizontal Spacing
const Widget horizontalSpaceTiny = SizedBox(
  width: 8,
);
const Widget horizontalSpaceSmall = SizedBox(
  width: 16,
);
const Widget horizontalSpaceRegular = SizedBox(
  width: 18,
);
const Widget horizontalSpaceMedium = SizedBox(
  width: 25,
);
const Widget horizontalSpaceLarge = SizedBox(
  width: 50,
);

// Vertical Spacing
const Widget verticalSpaceMinute = SizedBox(
  height: 4,
);
const Widget verticalSpaceTiny = SizedBox(
  height: 8,
);
const Widget verticalSpaceSmall = SizedBox(
  height: 16,
);
const Widget verticalSpaceIntermitent = SizedBox(
  height: 32,
);
const Widget verticalSpaceRegular = SizedBox(
  height: 48,
);
const Widget verticalSpaceMedium = SizedBox(
  height: 64,
);
const Widget verticalSpaceLarge = SizedBox(
  height: 128,
);

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
