import 'package:flutter/material.dart';

import '../../../constants/style_constants.dart';

class HomeScreenAdsWidget {
  Container addsCard(MediaQueryData mediaQuery, BuildContext context,
      StyleConstants styleConstants) {
    return Container(
        height: 192,
        width: mediaQuery.size.width,
        child: Card(
          child: Container(
              padding: EdgeInsets.all(styleConstants.largeDp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(StyleConstants().mediumRadius.toDouble())),
                image: DecorationImage(
                  image: AssetImage("images/img.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "تركيب محولة جديدة",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text("فك اختناق حي الامانة",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.end),
                )
              ])),
        ));
  }
}
