import 'package:fl_chart/fl_chart.dart';
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
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                  color: Colors.black, fontSize: styleConstants.headLine3)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: HomeBody(
              mediaQuery: mediaQuery,
            )));
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.mediaQuery});

  final MediaQueryData mediaQuery;

  @override
  State<HomeBody> createState() => _HomeBodyState(mediaQuery);
}

class _HomeBodyState extends State<HomeBody> {
  final MediaQueryData mediaQuery;

  int? toucnedIndex = 0;
  StyleConstants styleConstants = StyleConstants();

  _HomeBodyState(this.mediaQuery);

  @override
  Widget build(BuildContext context) {
    bool isTouched = false;
    return Container(
      padding: EdgeInsets.all(styleConstants.largeDp),
      width: double.infinity,
      child: Column(children: [
        HomeScreenAdsWidget().addsCard(mediaQuery, context, styleConstants),
        SizedBox(
          height: styleConstants.mediumDp,
        ),
        HomeScreenLatestChangesWidget()
            .latestChangesCard(mediaQuery, context, styleConstants),
        SizedBox(
          height: styleConstants.extraLargeDp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: styleConstants.mediumDp,
            ),
            Expanded(
                child: HomeScreenTransformerStatisticsCardWidget()
                    .transformerStatistics(
                    styleConstants, context, "عدد المغذيات", "1200")),
            SizedBox(
              width: styleConstants.extraLargeDp,
            ),
            Expanded(
                child: HomeScreenTransformerStatisticsCardWidget()
                    .transformerStatistics(
                    styleConstants, context, "اجمالي المحولات", "500")),
            SizedBox(
              width: styleConstants.mediumDp,
            ),
          ],
        ),
        SizedBox(
          height: styleConstants.extraLargeDp,
        ),
        Center(
          child: Container(
            width: mediaQuery.size.width,
            margin: EdgeInsets.all(styleConstants.largeDp),
            padding: EdgeInsets.all(styleConstants.extraLargeDp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(styleConstants.largeDp.toDouble())),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("توزيع المحولات",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.black,
                            fontSize: styleConstants.headLine3))),
                SizedBox(height: styleConstants.extraLargeDp,),
                SizedBox(
                  height: 300,
                  width: mediaQuery.size.width,
                  child: PieChart(
                    PieChartData(
                        sectionsSpace: 0,
                        sections: getPieChartSections(
                            isTouched, toucnedIndex, context),
                        pieTouchData: PieTouchData(
                          enabled: true,
                          touchCallback: (p0, p1) {
                            setState(() {
                              isTouched = !isTouched;
                              toucnedIndex =
                                  p1?.touchedSection?.touchedSectionIndex;
                              //      print("is touch $isTouched");
                              getPieChartSections(
                                  isTouched, toucnedIndex, context);
                            });
                            /*    print(
                                    "p0 is ${p0.isInterestedForInteractions} and p1 is ${p1?.touchedSection?.touchedSection?.value}");
                                isTouched = !isTouched;
                                toucnedIndex = p1?.touchedSection?.touchedSectionIndex;
                                print("is touch $isTouched");
                                getPieChartSections(isTouched, toucnedIndex);*/
                          },
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: styleConstants.extraLargeDp,
        ),
      ]),
    );
  }
}

/*Container _body(BuildContext context, MediaQueryData mediaQuery,
    StyleConstants styleConstants) {
  final String pieValue = "50";
  bool isTouched = false;
  int? toucnedIndex = 0;
  final listOfPieData = _getPieChart();
  return Container(
    padding: EdgeInsets.all(styleConstants.largeDp),
    width: mediaQuery.size.width,
    child: Column(children: [
      HomeScreenAdsWidget().addsCard(mediaQuery, context, styleConstants),
      SizedBox(
        height: styleConstants.mediumDp,
      ),
      HomeScreenLatestChangesWidget()
          .latestChangesCard(mediaQuery, context, styleConstants),
      SizedBox(
        height: styleConstants.extraLargeDp,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: styleConstants.mediumDp,
          ),
          Expanded(
              child: HomeScreenTransformerStatisticsCardWidget()
                  .transformerStatistics(
                      styleConstants, context, "عدد المغذيات", "1200")),
          SizedBox(
            width: styleConstants.extraLargeDp,
          ),
          Expanded(
              child: HomeScreenTransformerStatisticsCardWidget()
                  .transformerStatistics(
                      styleConstants, context, "اجمالي المحولات", "500")),
          SizedBox(
            width: styleConstants.mediumDp,
          ),
        ],
      ),
      SizedBox(
        height: styleConstants.extraLargeDp,
      ),
      Center(
        child: Container(
          height: 200,
          width: 200,
          child: PieChart(
            PieChartData(
                sections: getPieChartSections(isTouched,toucnedIndex),
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (p0, p1) {
                    print(
                        "p0 is ${p0.isInterestedForInteractions} and p1 is ${p1?.touchedSection?.touchedSection?.value}");
                    isTouched = !isTouched;
                    toucnedIndex = p1?.touchedSection?.touchedSectionIndex;
                    print("is touch $isTouched");
                    getPieChartSections(isTouched, toucnedIndex);
                  },
                )
            ) ,
          ),
        ),
      ),
      SizedBox(
        height: styleConstants.extraLargeDp,
      ),
    ]),
  );
}*/

List<PieChartSectionData> getPieChartSections(bool isTouched, int? toucnedIndex,
    BuildContext context) {
  final List<SinglePieChartData> pieChartData = _getPieChart();
  if (toucnedIndex != null &&
      toucnedIndex >= 0 &&
      toucnedIndex < pieChartData.length)
    pieChartData[toucnedIndex].isTouched = true;
  else
    pieChartData[0].isTouched = true;

  print("touchedIndex $toucnedIndex and isTouched $isTouched");
  pieChartData.forEach((element) {
    print("element is ${element.name} and ${element.isTouched}");
  });
  return [
    PieChartSectionData(
        color: pieChartData[0].color,
        value: pieChartData[0].isTouched ? 20 : pieChartData[0].value,
        radius: !pieChartData[0].isTouched ? pieChartData[0].radius : 110,
        title: pieChartData[0].name,
        titleStyle: Theme
            .of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
        showTitle: !pieChartData[0].isTouched ? true : false,
        badgeWidget: pieChartData[0].isTouched
            ? Visibility(
            child: Text(
              "15 محولة",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ))
            : Container()),
    PieChartSectionData(
      color: pieChartData[1].color,
      value: pieChartData[1].isTouched ? 20 : pieChartData[1].value,
      radius: !pieChartData[1].isTouched ? pieChartData[1].radius : 110,
      title: pieChartData[1].name,
      showTitle: !pieChartData[1].isTouched ? true : false,
      badgeWidget: pieChartData[1].isTouched
          ? Visibility(
          child: Text(
            " محولة 8",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[2].color,
      value: pieChartData[2].isTouched ? 20 : pieChartData[2].value,
      radius: !pieChartData[2].isTouched ? pieChartData[2].radius : 110,
      title: pieChartData[2].name,
      showTitle: !pieChartData[2].isTouched ? true : false,
      badgeWidget: pieChartData[2].isTouched
          ? Visibility(
          child: Text(
            " محولة 10",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[3].color,
      value: pieChartData[3].isTouched ? 20 : pieChartData[3].value,
      radius: !pieChartData[3].isTouched ? pieChartData[3].radius : 110,
      title: pieChartData[3].name,
      showTitle: !pieChartData[3].isTouched ? true : false,
      badgeWidget: pieChartData[3].isTouched
          ? Visibility(
          child: Text(
            " محولة 12",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[4].color,
      value: pieChartData[4].isTouched ? 20 : pieChartData[4].value,
      radius: !pieChartData[4].isTouched ? pieChartData[4].radius : 110,
      title: pieChartData[4].name,
      showTitle: !pieChartData[4].isTouched ? true : false,
      badgeWidget: pieChartData[4].isTouched
          ? Visibility(
          child: Text(
            " محولة 15",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[5].color,
      value: pieChartData[5].isTouched ? 20 : pieChartData[5].value,
      radius: !pieChartData[5].isTouched ? pieChartData[5].radius : 110,
      title: pieChartData[5].name,
      showTitle: !pieChartData[5].isTouched ? true : false,
      badgeWidget: pieChartData[5].isTouched
          ? Visibility(
          child: Text(
            " محولة 12",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[6].color,
      value: pieChartData[6].isTouched ? 20 : pieChartData[6].value,
      radius: !pieChartData[6].isTouched ? pieChartData[6].radius : 110,
      title: pieChartData[6].name,
      showTitle: !pieChartData[6].isTouched ? true : false,
      badgeWidget: pieChartData[6].isTouched
          ? Visibility(
          child: Text(
            " محولة 10",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[7].color,
      value: pieChartData[7].isTouched ? 20 : pieChartData[7].value,
      radius: !pieChartData[7].isTouched ? pieChartData[7].radius : 110,
      title: pieChartData[7].name,
      showTitle: !pieChartData[7].isTouched ? true : false,
      badgeWidget: pieChartData[7].isTouched
          ? Visibility(
          child: Text(
            " محولة 12",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[8].color,
      value: pieChartData[8].isTouched ? 20 : pieChartData[8].value,
      radius: !pieChartData[8].isTouched ? pieChartData[8].radius : 110,
      title: pieChartData[8].name,
      showTitle: !pieChartData[8].isTouched ? true : false,
      badgeWidget: pieChartData[8].isTouched
          ? Visibility(
          child: Text(
            " محولة 7",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[9].color,
      value: pieChartData[9].isTouched ? 20 : pieChartData[9].value,
      radius: !pieChartData[9].isTouched ? pieChartData[9].radius : 110,
      title: pieChartData[9].name,
      showTitle: !pieChartData[9].isTouched ? true : false,
      badgeWidget: pieChartData[9].isTouched
          ? Visibility(
          child: Text(
            " محولة 22",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[10].color,
      value: pieChartData[10].isTouched ? 20 : pieChartData[10].value,
      radius: !pieChartData[10].isTouched ? pieChartData[10].radius : 110,
      title: pieChartData[10].name,
      showTitle: !pieChartData[10].isTouched ? true : false,
      badgeWidget: pieChartData[10].isTouched
          ? Visibility(
          child: Text(
            " محولة 30",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: pieChartData[11].color,
      value: pieChartData[11].isTouched ? 20 : pieChartData[11].value,
      radius: !pieChartData[11].isTouched ? pieChartData[11].radius : 110,
      title: pieChartData[11].name,
      showTitle: !pieChartData[11].isTouched ? true : false,
      badgeWidget: pieChartData[11].isTouched
          ? Visibility(
          child: Text(
            " محولة 15",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ))
          : Container(),
      titleStyle: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
    ),
  ];
}

List<SinglePieChartData> _getPieChart() {
  return [
  SinglePieChartData(
      name: "قطاع 0",
      color: Colors.red,
      value: 10,
      radius: 100,
      isTouched: false)
  ,
  SinglePieChartData(
  name: "قطاع 1",
  color: Colors.green,
  value: 10,
  radius: 100,
  isTouched: false),
  SinglePieChartData(
  name: "قطاع 2",
  color: Colors.brown,
  value: 10,
  radius: 100,
  isTouched: false),
  SinglePieChartData(
  name: "قطاع 3",
  color: Colors.purple,
  value: 10,
  radius: 100,
  isTouched: false),
  SinglePieChartData(
  name: "قطاع 4",
  color: Colors.blue,
  value: 10,
  radius: 100,
  isTouched: false),
  SinglePieChartData(
  name: "قطاع 5",
  color: Colors.orange,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "قطاع 6",
  color: Colors.indigo,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "قطاع 7",
  color: Colors.pink,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "قطاع 8",
  color: Colors.grey,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "قطاع 9",
  color: Colors.black,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "حي الامانة",
  color: Colors.teal,
  value: 10,
  radius: 100,
  isTouched: false),
    SinglePieChartData(
  name: "نواب الضباط",
  color: Colors.cyan,
  value: 10,
  radius: 100,
  isTouched: false),
  ];
}

class SinglePieChartData {
  final String name;
  final Color color;
  bool isTouched = false;
  final double value;
  final double radius;

  SinglePieChartData({required this.name,
    required this.color,
    required this.value,
    required this.radius,
    required this.isTouched});
}
