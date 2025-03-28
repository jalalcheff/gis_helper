import 'package:flutter/material.dart';

import '../../../constants/style_constants.dart';

class HomeScreenLatestChangesWidget {
  Container latestChangesCard(MediaQueryData mediaQuery, BuildContext context,
      StyleConstants styleConstants) {
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
          _itemLatestChanges(
              mediaQuery,
              context,
              styleConstants,
              Color(styleConstants.colorGreenBackgroundTernary),
              Color(styleConstants.colorSecondaryNormal),
              Color(styleConstants.colorGreenBackgroundNormal),
              Colors.green,
              Icons.add,
              "اضافة محولة",
              "تم اضافة محولة 322 الى قطاع 5",
              "قبل 1 ساعة"),
          SizedBox(
            height: styleConstants.smallDp,
          ),
          _itemLatestChanges(
              mediaQuery,
              context,
              styleConstants,
              Color(styleConstants.colorBlueBackgroundTernary),
              Color(styleConstants.colorSecondaryNormal),
              Color(styleConstants.colorBlueBackgroundNormal),
              Colors.blue,
              Icons.edit_note,
              "تحديث بيانات",
              "تم تغيير موقع المحولة 332",
              "قبل 10 ساعة"),
          SizedBox(
            height: styleConstants.smallDp,
          ),
          _itemLatestChanges(
              mediaQuery,
              context,
              styleConstants,
              Color(styleConstants.colorRedBackgroundTernary),
              Color(styleConstants.colorSecondaryNormal),
              Color(styleConstants.colorRedBackgroundNormal),
              Colors.red,
              Icons.delete,
              "ازالة محولة",
              "تم ازالة المحولة 211",
              "قبل 10 يوم"),
        ],
      ),
    );
  }

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
}
