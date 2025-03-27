import 'package:gis_helper/constants/shadow.dart';

class StyleConstants{
  int smallRadius = 2;
  int mediumRadius = 4;
  int largeRadius = 8;
  int extraLargeRadius = 16;
  int headLine1 = 32; //primary
  int headLine2 = 30; //secondary
  int headLine3 = 20; //tertiary
  int headLine4 = 18; //quaternary
  int captionFont = 12;
  int bodyFont = 14;
  String colorPrimaryNormal = "#22C55E";
  String colorSecondaryNormal = "#3B82F6";
  String colorBlueBackgroundTernary = "#EFF6FF";
  String colorGreenBackgroundTernary = "#F0FDF4";
  String colorRedBackgroundTernary = "#FEF2F2";
  String colorBlueBackgroundSecondary = "#DBEAFE";
  String colorGreenBackgroundSecondary = "#DCFCE7";
  String colorRedBackgroundSecondary = "#FEE2E2";
  String colorBlueBackgroundNormal = "#3261FF";
  String colorGreenBackgroundNormal = "#17D077";
  String colorRedBackgroundNormal = "#FA4323";
  int thinStroke = 1;
  int regularStroke = 2;
  int thickStroke = 3;
  Shadow smallShadow = Shadow(xOffset: 0, yOffset: 1, blur: 2, spread: 0, color: "#000000", opacity: 5);
  Shadow mediumShadow = Shadow(xOffset: 0, yOffset: 1, blur: 4, spread: 0, color: "#000000", opacity: 15);
  Shadow largeShadow = Shadow(xOffset: 0, yOffset: 1, blur: 8, spread: 0, color: "#000000", opacity: 25);

}