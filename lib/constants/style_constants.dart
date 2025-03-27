import 'package:gis_helper/constants/shadow.dart';

class StyleConstants{
  int smallRadius = 2;
  int mediumRadius = 4;
  int largeRadius = 8;
  int extraLargeRadius = 16;
  double headLine1 = 32; //primary
  double headLine2 = 30; //secondary
  double headLine3 = 20; //tertiary
  double headLine4 = 18; //quaternary
  double captionFont = 12;
  double bodyFont = 14;
  int backgroundColor = 0xFFF9FAFB;
  int colorPrimaryNormal = 0xFF22C55E;
  int colorSecondaryNormal = 0xFF3B82F6;
  int colorBlueBackgroundTernary = 0xFFEFF6FF;
  int colorGreenBackgroundTernary = 0xFFF0FDF4;
  int colorRedBackgroundTernary = 0xFFFEF2F2;
  int colorBlueBackgroundSecondary = 0xFFDBEAFE;
  int colorGreenBackgroundSecondary = 0xFFDCFCE7;
  int colorRedBackgroundSecondary = 0xFFFEE2E2;
  int colorBlueBackgroundNormal = 0xFFDBEAFE;
  int colorGreenBackgroundNormal = 0xFFDCFCE7;
  int colorRedBackgroundNormal = 0XFFFEE2E2;
  int colorBlack = 0x00000000;
  int colorWhite = 0xFFFFFFFF;
  int colorGrey = 0xFF6B7280;
  int thinStroke = 1;
  int regularStroke = 2;
  int thickStroke = 3;
  Shadow smallShadow = Shadow(xOffset: 0, yOffset: 1, blur: 2, spread: 0, color: "000000", opacity: 5);
  Shadow mediumShadow = Shadow(xOffset: 0, yOffset: 1, blur: 4, spread: 0, color: "000000", opacity: 15);
  Shadow largeShadow = Shadow(xOffset: 0, yOffset: 1, blur: 8, spread: 0, color: "000000", opacity: 25);
  double smallDp = 2;
  double mediumDp = 4;
  double largeDp = 8;
  double extraLargeDp = 16;
}