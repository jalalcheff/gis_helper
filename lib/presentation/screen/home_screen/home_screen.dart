import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/list_and_maps.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:gis_helper/presentation/cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/sign_in_cubit/sign_in_cubit.dart';
import 'package:gis_helper/presentation/cubit/signout_cubit/signout_cubit.dart';
import 'package:gis_helper/presentation/cubit/update_all_transformers_cubit/update_all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/user_accountdata_cubit/user_accountdata_cubit.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_ads_widget.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_latest_changes_widget.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen_transformer_statistics_card_widget.dart';
import 'package:gis_helper/presentation/screen/sign_in_screen/sign_in_screen.dart';

import '../../../data/repository/account_repository_imp.dart';
import '../../../di/dependency_injection.dart';
import '../../../domain/signout_usecase.dart';
import '../../cubit/feeders_number_cubit/feeders_number_cubit.dart';
import '../../cubit/latest_changes_cubit/latest_changes_cubit.dart';
import '../../cubit/transformer_number_cubit/transformer_number_cubit.dart';
import '../../cubit/transformer_number_of_each_sector_cubit/transformer_number_of_each_sector_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StyleConstants styleConstants = StyleConstants();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return BlocListener<SignoutCubit, SignoutState>(
        listener: (context, state) {
          switch (state) {
            case SignoutInitial():
              {}
            case SignoutSuccess():
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => locator<SignInCubit>(),
                      child: SignInScreen(),
                    ),
                  ),
                );
              }
            case SignoutError():
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("حدث خطأ أثناء تسجيل الخروج")),
                );
              }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BlocBuilder<UserAccountdataCubit, UserAccountdataState>(
                builder: (context, state) {
              return switch (state) {
                UserAccountdataInitial() => Icon(Icons.logout),
                UserAccountdataSuccess() => PopupMenuButton(
                    onSelected: ((value) {
                      if (value == "logout") {
                        _showLogoutConfirmationDialog(context);
                      } else if (value == "add") {
                      } else if (value == "update") {
                        context
                            .read<UpdateAllTransformersCubit>()
                            .loadAllTransformers();
                      }
                    }),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Text("تحديث البيانات"), value: "update"),
                      if (state.userAccountdata.role == "admin")
                        PopupMenuItem(child: Text("انشاء حساب"), value: "add"),
                      PopupMenuItem(
                          child: Text("تسجيل الخروج",
                              style: TextStyle(color: Colors.red)),
                          value: "logout"),
                    ],
                    icon: Icon(Icons.more_vert),
                  ),
                UserAccountdataError() => Container(),
              };
            }),
            title: Text("الصفحة الرئيسية",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black, fontSize: styleConstants.headLine3)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: HomeBody(
            mediaQuery: mediaQuery,
          )),
        ));
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('تأكيد تسجيل الخروج'),
            content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
            actions: [
              TextButton(
                child: Text('لا'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // إغلاق النافذة بدون حذف
                },
              ),
              TextButton(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: styleConstants.largeDp,
                      horizontal: styleConstants.extraLargeDp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(styleConstants.largeDp),
                    color: Colors.red,
                  ),
                  child: Text('نعم',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white)),
                ),
                onPressed: () async {
                  await context.read<SignoutCubit>().emitSignOut();
                  // نفّذ عملية الحذف هنا
                },
              )
            ],
          );
        });
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.mediaQuery,
  });

  final MediaQueryData mediaQuery;

  /*final TransformerNumberCubit transformerNumberCubit;
  final FeedersNumberCubit feedersNumberCubit;
  final AllTransformersCubit transformersCubit;
  final MediaQueryData mediaQuery;
  final TransformerNumberOfEachSectorCubit transformerNumberOfEachSectorCubit;
  final bool isDeleteOrUpdate;
  final UpdateAllTransformersCubit updateAllTransformerCubit;*/

  @override
  State<HomeBody> createState() => _HomeBodyState(mediaQuery);
}

class _HomeBodyState extends State<HomeBody> {
  final MediaQueryData mediaQuery;

  int? toucnedIndex = 0;
  StyleConstants styleConstants = StyleConstants();

  _HomeBodyState(this.mediaQuery);

  @override
  void initState() {
    context.read<AllTransformersCubit>().loadAllTransformers([]);
    context.read<FeedersNumberCubit>().emitFeedersNumber();
    context.read<TransformerNumberCubit>().emitTransformerNumber();
    context
        .read<TransformerNumberOfEachSectorCubit>()
        .emitTransformerNumberOfEachSector();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isTouched = false;
    return BlocListener<UpdateAllTransformersCubit, UpdateAllTransformersState>(
      listener: (context, state) {
        switch (state) {
          case UpdateAllTransformersInitial():
            break;
          case UpdateAllTransformersLoaded():
            {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("تم تحديث البيانات")),
                      snackBarAnimationStyle: AnimationStyle(
                        duration: Duration(seconds: 2),
                      ));
            }
          case UpdateAllTransformerError():
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("حدث خطأ أثناء تحديث البيانات")),
                  snackBarAnimationStyle: AnimationStyle());
            }
        }
      },
      child: Container(
        padding: EdgeInsets.all(styleConstants.largeDp),
        width: double.infinity,
        child: Column(children: [
          HomeScreenAdsWidget().addsCard(mediaQuery, context, styleConstants),
          SizedBox(
            height: styleConstants.mediumDp,
          ),
          HomeScreenLatestChangesWidget(),
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
                  child: BlocBuilder<FeedersNumberCubit, FeedersNumberState>(
                builder: (context, state) {
                  if (state is FeedersNumberLoaded) {
                    return HomeScreenTransformerStatisticsCardWidget()
                        .transformerStatistics(styleConstants, context,
                            "عدد المغذيات", state.feedersNumber.toString());
                  } else if (state is FeedersNumberError) {
                    print("feeder number error is ${state.error}");
                    return HomeScreenTransformerStatisticsCardWidget()
                        .transformerStatistics(
                            styleConstants, context, "اجمالي المغذيات", "خطأ");
                  } else {
                    return HomeScreenTransformerStatisticsCardWidget()
                        .transformerStatistics(styleConstants, context,
                            "اجمالي المغذيات", "لودنج");
                  }
                },
              )),
              SizedBox(
                width: styleConstants.extraLargeDp,
              ),
              Expanded(
                child:
                    BlocBuilder<TransformerNumberCubit, TransformerNumberState>(
                  builder: (context, state) {
                    if (state is TransformerNumberLoaded) {
                      return HomeScreenTransformerStatisticsCardWidget()
                          .transformerStatistics(
                              styleConstants,
                              context,
                              "عدد المحولات",
                              state.transformerNumber.toString());
                    } else if (state is TransformerNumberError) {
                      return HomeScreenTransformerStatisticsCardWidget()
                          .transformerStatistics(styleConstants, context,
                              "اجمالي المحولات", "خطأ");
                    } else {
                      return HomeScreenTransformerStatisticsCardWidget()
                          .transformerStatistics(styleConstants, context,
                              "اجمالي المحولات", "لودنج");
                    }
                  },
                ),
              ),
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
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize: styleConstants.headLine3))),
                  SizedBox(
                    height: styleConstants.extraLargeDp,
                  ),
                  SizedBox(
                    height: 300,
                    width: mediaQuery.size.width,
                    child: BlocBuilder<TransformerNumberOfEachSectorCubit,
                        TransformerNumberOfEachSectorState>(
                      builder: (context, state) {
                        if (state is TransformerNumberOfEachSectorLoaded) {
                          return PieChart(
                            PieChartData(
                              sectionsSpace: 0,
                              sections: getPieChartSections(
                                  isTouched,
                                  toucnedIndex,
                                  context,
                                  _getPieChart(state.transformers),
                                  state.transformers),
                              pieTouchData: PieTouchData(
                                enabled: true,
                                touchCallback: (p0, p1) {
                                  setState(() {
                                    isTouched = !isTouched;
                                    toucnedIndex =
                                        p1?.touchedSection?.touchedSectionIndex;
                                    //      print("is touch $isTouched");
                                    getPieChartSections(
                                        isTouched,
                                        toucnedIndex,
                                        context,
                                        _getPieChart(state.transformers),
                                        state.transformers);
                                  });
                                },
                              ),
                            ),
                          );
                        } else if (state is AllTransformersInitial) {
                          return const CircularProgressIndicator();
                        } else {
                          return Container();
                        }
                      },
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
      ),
    );
  }
}

List<PieChartSectionData> getPieChartSections(
    bool isTouched,
    int? toucnedIndex,
    BuildContext context,
    List<SinglePieChartData> pieChartData,
    List<Map<String, dynamic>> transformersNumber) {
//  final List<SinglePieChartData> pieChartData = _getPieChart();
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
  List<PieChartSectionData> pieChartSections = [];
  int counter = 0;
  for (var myPieChartData in pieChartData) {
    pieChartSections.add(PieChartSectionData(
        color: myPieChartData.color,
        value: myPieChartData.isTouched ? 20 : myPieChartData.value,
        radius: !myPieChartData.isTouched ? myPieChartData.radius : 110,
        title: myPieChartData.name,
        titleStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
        showTitle: !myPieChartData.isTouched ? true : false,
        badgeWidget: myPieChartData.isTouched
            ? Visibility(
                child: Text(
                transformersNumber[counter].values.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ))
            : Container()));
    counter++;
  }
  return pieChartSections;
}

List<SinglePieChartData> _getPieChart(List<Map<String, dynamic>> transformers) {
  final List<SinglePieChartData> pieChartData = [];
  List<Color> listOfColors = ListAndMaps().listOfColors;
  for (int i = 0; i < transformers.length; i++) {
    pieChartData.add(SinglePieChartData(
        name: transformers[i].keys.toString(),
        color: listOfColors[i],
        value: 10,
        radius: 100,
        isTouched: false));
  }
  return pieChartData;
}

class SinglePieChartData {
  final String name;
  final Color color;
  bool isTouched = false;
  final double value;
  final double radius;

  SinglePieChartData(
      {required this.name,
      required this.color,
      required this.value,
      required this.radius,
      required this.isTouched});
}
