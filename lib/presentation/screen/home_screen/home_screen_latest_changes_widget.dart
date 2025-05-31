import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import '../../../constants/style_constants.dart';
import '../../../di/dependency_injection.dart';
import '../../../domain/model/transformer_model.dart';
import '../../cubit/latest_changes_cubit/latest_changes_cubit.dart';

class HomeScreenLatestChangesWidget extends StatefulWidget {


  const HomeScreenLatestChangesWidget({super.key});

  @override
  State<HomeScreenLatestChangesWidget> createState() => _HomeScreenLatestChangesWidgetState();
}

class _HomeScreenLatestChangesWidgetState extends State<HomeScreenLatestChangesWidget> {

  @override
  void initState() {
    context.read<LatestChangesCubit>().loadLatestChanges();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    StyleConstants styleConstants = StyleConstants();
    return BlocBuilder<LatestChangesCubit, LatestChangesState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: styleConstants.largeDp),
            padding: EdgeInsets.only(top: styleConstants.largeDp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(styleConstants.largeDp.toDouble())),
              color: Colors.white,
            ),
            width: mediaQuery.size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(styleConstants.largeDp),
                  alignment: Alignment.topRight,
                  child: Text(
                    "الانشطة الاخيرة",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                if (state is LatestChangesInitial)
                  const Center(child: CircularProgressIndicator())
                else if (state is LatestChangesLoaded)
                  _buildLatestChanges(state.latestTransformers, mediaQuery, context, styleConstants)
                else if (state is LatestChangesError)
                  Center(child: Text(state.error.toString()))
                else
                  const Center(child: Text('something went wrong')),
              ],
            ),
          );
        },
      );
  }

  Widget _buildLatestChanges(List<TransformerModel> result, MediaQueryData mediaQuery, BuildContext context, StyleConstants styleConstants) {
    return  Column(
          children: result.map((transformer) {
            return Column(
              children: [
                _itemLatestChanges(
                  mediaQuery,
                  context,
                  styleConstants,
                  Color(styleConstants.colorGreenBackgroundTernary),
                  Color(styleConstants.colorSecondaryNormal),
                  Color(styleConstants.colorGreenBackgroundNormal),
                  Colors.green,
                  Icons.add,
                  "${transformer.transformerName} اضافة المحولة ",
                  'رقم المحولة ${transformer.transformerSerialNumber} في ${transformer.mahlaOrSector}',
                  'Recent',
                ),
                SizedBox(height: styleConstants.smallDp),
              ],
            );
          }).toList(),
        );
      }
  }

 /* extension ResultExtension<T> on Result<T> {
    R when<R>({
      required R Function(T) ok,
      required R Function(Object) error,
    }) {
      return switch (this) {
        Ok<T>(value: final v) => ok(v),
        ErrorValue<T>(e: final e) => error(e),
      };
    }
  }*/


  Container _itemLatestChanges(
      MediaQueryData mediaQuery,
      BuildContext context,
      StyleConstants styleConstants,
      Color cardBackground,
      Color textColor,
      Color iconBackground,
      Color iconColor,
      IconData icon,
      String title,
      String subtitle,
      String time) {
    return Container(
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(styleConstants.largeDp.toDouble())),
          color: cardBackground,
        ),
        padding: EdgeInsets.all(styleConstants.largeDp),
        margin: EdgeInsets.all(styleConstants.largeDp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black, fontSize: styleConstants.headLine3),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  width: styleConstants.largeDp,
                ),
                Container(
                    padding: EdgeInsets.all(styleConstants.largeDp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(99)),
                      color: iconBackground,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                    ))
              ],
            )
          ],
        ));
  }
