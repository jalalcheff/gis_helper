import 'package:flutter/material.dart';
import 'package:gis_helper/constants/style_constants.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  StyleConstants styleConstants = StyleConstants();
  Map<String, dynamic> transformerData = {
    "ارضية": "option1",
    "هوائية": "option2",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("تعديل تفاصيل المحولة",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black, fontSize: styleConstants.headLine3))),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(styleConstants.extraLargeDp),
          child: Column(
            children: [
              _textFormField("اسم المحولة"),
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("رقم المحولة"),
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "سعة المحولة", {
                "250 كي في اي": "250 kva",
                "400 كي في اي": "400 kva",
                "1000 كي في اي": "1000 kva",
              }), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "هل هي محولة هوائية ؟", {
                "نعم": true,
                "لا": false,
              }), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "هل هي محولة خاصة ؟", {
                "لا": false,
                "نعم": true,
              }),  //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "اسم المغذي", {
                "9 قدس": "250 kva",
                "10 فلاح": "400 kva",
                "4 قدس": "1000 kva",
              }),  //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "اسم المحطة", {
                "القدس": "250 kva",
                "الفلاح": "400 kva",
                "المثنى": "1000 kva",
              }),  //drop down
              SizedBox(height: styleConstants.extraLargeDp),
            _transformerDataDropdownMenu(
                "محلة او قطاع", {
              "9 قطاع": "250 kva",
              "10 قطاع": "400 kva",
              "4 قطاع": "1000 kva",
              "523 محلة" : "تنبيت"
               }), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "زقاق او بلوك", {
                "9 بلوك": "250 kva",
                "10 بلوك": "400 kva",
                "4 بلوك": "1000 kva",
                "523 زقاق" : "تنبيت"
              }), //drop down
              SizedBox(height: styleConstants.extraLargeDp),
              _transformerDataDropdownMenu("نوع المحولة", transformerData),
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("X الاحداثي"),
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("Y الاحداثي"),
            ],
          ),
        ),
      ),
      backgroundColor: Color(StyleConstants().backgroundColor),
    );
  }

  Column _textFormField(String label) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(label,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black))),
        TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
              borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp),
            ),
          ),
        ),
      ],
    );
  }

  /*DropdownMenu _feedersDropdownMenu() {
   return DropdownMenu(
        menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(styleConstants.colorWhite)),
            side: WidgetStatePropertyAll(
                BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp,
                )
            )
        ),
        width: MediaQuery.of(context).size.width,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
            borderSide: BorderSide(
                color: Color(styleConstants.colorLightGrey),
                width: styleConstants.smallDp),
          ),
        ),
        initialSelection: "option1",
        dropdownMenuEntries:[
          DropdownMenuEntry(value: "option1", label: "1 مثنى"),
          DropdownMenuEntry(value: "option2", label: "2 مثنى"),
          DropdownMenuEntry(value: "option3", label: "9 قدس"),
        ]
    );
  }*/
  Column _transformerDataDropdownMenu(String title, Map<String, dynamic> data) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),)),
        SizedBox(height: styleConstants.smallDp),
        DropdownMenu(
          textAlign: TextAlign.end,
            menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Color(styleConstants.colorWhite)),
                side: WidgetStatePropertyAll(
                    BorderSide(
                      color: Color(styleConstants.colorLightGrey),
                      width: styleConstants.smallDp,
                    )
                )
            ),
            width: MediaQuery.of(context).size.width,
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
                borderSide: BorderSide(
                    color: Color(styleConstants.colorLightGrey),
                    width: styleConstants.smallDp),
              ),
            ),
            initialSelection: data.values.first,
            dropdownMenuEntries: data.map((key, value) => MapEntry(key, DropdownMenuEntry(value: value, label: key))).values.toList()
        ),
      ],
    );
  }
}
