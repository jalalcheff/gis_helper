import 'package:flutter/material.dart';

import '../../../constants/style_constants.dart';

class HomeScreenTransformerStatisticsCardWidget {
  Container transformerStatistics(StyleConstants styleConstants, BuildContext context,String title, String value) {
    return Container(
      padding: EdgeInsets.all(styleConstants.extraLargeDp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(styleConstants.largeDp.toDouble())),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),),
          SizedBox(height: styleConstants.extraLargeDp,),
          Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, fontSize: styleConstants.headLineLess2),)
        ],
      ),
    );
  }
}