import 'package:flutter/material.dart';

import '../../../constants/style_constants.dart';

class TransformerDetailsScreen extends StatefulWidget {
  const TransformerDetailsScreen({super.key});

  @override
  State<TransformerDetailsScreen> createState() =>
      _TransformerDetailsScreenState();
}

class _TransformerDetailsScreenState extends State<TransformerDetailsScreen> {
  late StyleConstants styleConstants;
  late MediaQueryData mediaQuery;

  @override
  void initState() {
    styleConstants = StyleConstants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: TransformerDetailsScreenBody(),
    );
  }

  Padding TransformerDetailsScreenBody() {
    return Padding(
      padding: EdgeInsets.all(styleConstants.extraLargeDp),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "images/overhead.png",
                height: mediaQuery.size.height * 0.35,
              ),
              SizedBox(
                height: styleConstants.extraLargeDp,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "T188 محولة كهربائية",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontSize: styleConstants.headLineLess2),
                ),
              ),
              SizedBox(
                height: styleConstants.mediumDp,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: _buildTransformerSerialNumberCard()),
              SizedBox(
                height: styleConstants.mediumDp,
              ),
              Divider(
                color: Color(styleConstants.colorLightGrey),
                thickness: 1,
              ),
              SizedBox(
                height: styleConstants.mediumDp,
              ),
              _buildTransformerInformationCards(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTransformerSerialNumberCard() {
    return Container(
      padding: EdgeInsets.all(styleConstants.largeDp),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.17),
        borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
      ),
      child: Text("رقم المحولة : 12231",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
    );
  }

  Container _buildTransformerInformationCards() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleTransformerInformationCard(
                  "صنف المحولة", "هوائية", Icons.electric_bolt_sharp),
              _buildSingleTransformerInformationCard(
                  "عائدية المحولة", "حكومية", Icons.electric_bolt_sharp),
            ],
          ),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleTransformerInformationCard(
                  "سعة المحولة", "400 كي في اي", Icons.electric_bolt_sharp),
              _buildSingleTransformerInformationCard(
                  "اسم المغذي", "4 مثنى", Icons.electric_bolt_sharp),
            ],
          ),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          Divider(
            color: Color(styleConstants.colorLightGrey),
            thickness: 1,
          ),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          Align(
              alignment: Alignment.topRight,
              child: Text("معلومات الموقع",
                  style: Theme.of(context).textTheme.titleLarge)),
          SizedBox(height: styleConstants.extraLargeDp),
          _buildSingleTransformerLocationInformationCard(
              "اسم المحطة", "المثنى", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "الموقع", "حي الامانة / زقاق 13", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(longitude) x الاحداثي", "44.44113", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(latiitude) y الاحداثي", "33.33231", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
        ],
      ),
    );
  }

  Container _buildSingleTransformerInformationCard(
      String title, String subtitle, IconData icon) {
    return Container(
        width: mediaQuery.size.width * 0.42,
        padding: EdgeInsets.all(styleConstants.extraLargeDp),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.17),
            borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: styleConstants.mediumDp,
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ));
  }

  Container _buildSingleTransformerLocationInformationCard(
      String title, String subtitle, IconData icon) {
    return Container(
        padding: EdgeInsets.all(styleConstants.largeDp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                ),
                SizedBox(
                  width: styleConstants.largeDp,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            SizedBox(width: styleConstants.largeDp),
            Container(
              padding: EdgeInsets.all(styleConstants.largeDp),
              child: Icon(
                icon,
                color: Colors.blue,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(styleConstants.extraLargeDp),
                color: Colors.blue.withOpacity(0.17),
              ),
            ),
          ],
        ));
  }
}
