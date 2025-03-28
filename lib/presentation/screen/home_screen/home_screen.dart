import 'package:flutter/material.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_ads_widget.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_latest_changes_widget.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_transformer_statistics_card_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StyleConstants styleConstants = StyleConstants();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("الصفحة الرئيسية",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black, fontSize: styleConstants.headLine3)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: _body(context, mediaQuery, styleConstants)));
  }
}

Container _body(BuildContext context, MediaQueryData mediaQuery,
    StyleConstants styleConstants) {
  return Container(
    padding: EdgeInsets.all(styleConstants.largeDp),
    height: mediaQuery.size.height,
    width: mediaQuery.size.width,
    child: Column(children: [
      HomeScreenAdsWidget().addsCard(mediaQuery, context, styleConstants),
      SizedBox(height: styleConstants.mediumDp,),
      HomeScreenLatestChangesWidget().latestChangesCard(mediaQuery, context, styleConstants),
      SizedBox(height: styleConstants.extraLargeDp,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: styleConstants.mediumDp,),
          Expanded(child: HomeScreenTransformerStatisticsCardWidget().transformerStatistics(styleConstants,context,"عدد المغذيات","1200")),
          SizedBox(width: styleConstants.extraLargeDp,),
          Expanded(child: HomeScreenTransformerStatisticsCardWidget().transformerStatistics(styleConstants,context,"اجمالي المحولات","500")),
          SizedBox(width: styleConstants.mediumDp,),
        ],
      )
    ]),
  );
}
