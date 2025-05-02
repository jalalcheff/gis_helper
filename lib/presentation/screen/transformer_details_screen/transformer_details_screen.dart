import 'package:flutter/material.dart';

import '../../../constants/style_constants.dart';
import '../../../data/resource/transformer_resource.dart';

class TransformerDetailsScreen extends StatefulWidget {
  const TransformerDetailsScreen({super.key, required this.transformerDetails});
final TransformerResource transformerDetails;
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
                (widget.transformerDetails.isItOverhead) ?
                "images/overhead.png" : "images/kiosk.png",
                height: mediaQuery.size.height * 0.35,
              ),
              SizedBox(
                height: styleConstants.extraLargeDp,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${widget.transformerDetails.transformerName} محولة كهربائية",
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
      child: Text("${widget.transformerDetails.transformerSerialNumber} : رقم المحولة",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
    );
  }

  Container _buildTransformerInformationCards() {
    String isItOverhead = widget.transformerDetails.isItOverhead ? "محولة هوائية" : "محولة ارضية";
    String isItPrivate = widget.transformerDetails.isItPrivate ? "خاصة" : "حكومية";

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleTransformerInformationCard(
                  "صنف المحولة", isItOverhead, Icons.electric_bolt_sharp),
              _buildSingleTransformerInformationCard(
                  "عائدية المحولة", isItPrivate, Icons.electric_bolt_sharp),
            ],
          ),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleTransformerInformationCard(
                  "سعة المحولة", widget.transformerDetails.transformerCapacity, Icons.electric_bolt_sharp),
              _buildSingleTransformerInformationCard(
                  "اسم المغذي", widget.transformerDetails.feederName, Icons.electric_bolt_sharp),
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
              "اسم المحطة", widget.transformerDetails.substationName, Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "الموقع", "${getSectorOrMahala(widget.transformerDetails.mahlaOrSector)} / ${getSectorOrMahala(widget.transformerDetails.zuqaqOrBlock)}", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(longitude) x الاحداثي", "${widget.transformerDetails.xCoordinates}", Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(latiitude) y الاحداثي", "${widget.transformerDetails.yCoordinates}", Icons.electric_bolt_sharp),
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

  getSectorOrMahala(String mahlaOrSector) {
      if(mahlaOrSector.contains("قطاع") || mahlaOrSector.contains("بلوك")) {
        return mahlaOrSector.split(' ').reversed.join(' ');
      } else {
        return mahlaOrSector;
      }
  }
}
