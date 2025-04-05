import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/data/database_service/database_service_imp.dart';
import 'package:gis_helper/data/repository/transformer_repository_imp.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/di/dependency_injection.dart';
import 'package:gis_helper/domain/transformer_repository.dart';
import 'package:gis_helper/presentation/cubit/add_transformer_cubit/add_transformer_cubit.dart';

import '../../../domain/add_transformer_usecase.dart';
import '../../../domain/model/transformer_model.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}
class _DataEntryScreenState extends State<DataEntryScreen> {
  StyleConstants styleConstants = StyleConstants();
  late AddTransformerCubit _addTransformerCubit;
  Map<String, dynamic> transformerData = {
    "ارضية": "option1",
    "هوائية": "option2",
  };
  bool areAllFieldsValid = false;
  List<TextEditingController> transformerDataController = List.generate(11, (index) => TextEditingController());
  final TextEditingController transformerNameController = TextEditingController();
  final TextEditingController transformerNumberController = TextEditingController();
  final TextEditingController feederNameController = TextEditingController();
  final TextEditingController transformerXController = TextEditingController();
  final TextEditingController transformerYController = TextEditingController();
  final TextEditingController transformerCapacity = TextEditingController();
  final TextEditingController isItOverheadTransformerController = TextEditingController();
  final TextEditingController isItOwnedTransformerController = TextEditingController();
  final TextEditingController substationNameController = TextEditingController();
  final TextEditingController zuqaqOrBlockController = TextEditingController();
  final TextEditingController mahalaOrSectorController = TextEditingController();
  @override
  void initState() {
    _addTransformerCubit = locator<AddTransformerCubit>();
 //   _addTransformerCubit = AddTransformerCubit(AddTransformerUsecase(transformerRepository: TransformerRepositoryImp(apiService: ApiServiceImp(), databaseService: DatabaseServiceImp())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _checkValidity();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("تعديل تفاصيل المحولة",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black, fontSize: styleConstants.headLine3))),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
  create: (context) => _addTransformerCubit,
  child: Container(
          padding: EdgeInsets.all(styleConstants.extraLargeDp),
          child: Column(
            children: [
              _textFormField("اسم المحولة", transformerDataController[0], "T155"),
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("رقم المحولة", transformerDataController[1],"1221"),
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "سعة المحولة", {
                "250 كي في اي": "250 kva",
                "400 كي في اي": "400 kva",
                "1000 كي في اي": "1000 kva",
              }, transformerDataController[2]), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "هل هي محولة هوائية ؟", {
                "نعم": true,
                "لا": false,
              }, transformerDataController[3]), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "هل هي محولة خاصة ؟", {
                "لا": false,
                "نعم": true,
              }, transformerDataController[4]), //drop down),  //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "اسم المغذي", {
                "9 قدس": "250 kva",
                "10 فلاح": "400 kva",
                "4 قدس": "1000 kva",
              }, transformerDataController[5]),  //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "اسم المحطة", {
                "القدس": "250 kva",
                "الفلاح": "400 kva",
                "المثنى": "1000 kva",
              }, transformerDataController[6]),  //drop down
              SizedBox(height: styleConstants.extraLargeDp),
            _transformerDataDropdownMenu(
                "محلة او قطاع", {
              "9 قطاع": "250 kva",
              "10 قطاع": "400 kva",
              "4 قطاع": "1000 kva",
              "523 محلة" : "تنبيت"
               }, transformerDataController[7]), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _transformerDataDropdownMenu(
                  "زقاق او بلوك", {
                "9 بلوك": "250 kva",
                "10 بلوك": "400 kva",
                "4 بلوك": "1000 kva",
                "523 زقاق" : "تنبيت"
              }, transformerDataController[8]), //drop down
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("X الاحداثي", transformerDataController[9], "44.4421"),
              SizedBox(height: styleConstants.mediumDp),
              _textFormField("Y الاحداثي", transformerDataController[10], "33.33212"),
             // Expanded(child: Container()),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: styleConstants.extraLargeDp),
                alignment: Alignment.bottomCenter,
                child: BlocListener<AddTransformerCubit, AddTransformerState>(
  listener: (context, state) {
    if(state is AddTransformerLoaded){
      _clearAllFields();
      _showSnackBar(context, "تم إضافة المحولة بنجاح");
    }
    else if(state is AddTransformerError){
      _showSnackBar(context, "حدث خطأ أثناء إضافة المحولة");
    }
  },
  child: MaterialButton(
                  onPressed: !areAllFieldsValid ? (){} : (){
                    final TransformerModel transformer = _getTransformerData();
                    _addTransformerCubit.addTransformer(transformer, "${transformer.transformerName} ${transformer.transformerSerialNumber}");
                    print("data inside transformer capacity ${transformerDataController[2].text}");
                }, child: Text("اضافة المحولة", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(styleConstants.colorWhite)),
                ),
                  color: areAllFieldsValid ? Color(styleConstants.colorBlack) : Colors.grey[600],
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: styleConstants.extraLargeDp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)
                  ),
                ),
),
                ),
            ],
          ),
        ),
),
      ),
      backgroundColor: Color(StyleConstants().backgroundColor),
    );
  }

  Column _textFormField(String label, TextEditingController controller, String hint) {
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
          textDirection: TextDirection.rtl,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
              borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp),
            ),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(styleConstants.colorBlack).withOpacity(0.35)),
            hintTextDirection: TextDirection.rtl,
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

  Column _transformerDataDropdownMenu(String title, Map<String, dynamic> data, TextEditingController controller) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),)),
        SizedBox(height: styleConstants.smallDp),
        DropdownMenu(
          controller: controller,
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

   void _checkValidity() {
    bool tempValidity = true;
    transformerDataController.forEach((transformerDataController){
      if(transformerDataController.text.trim().isEmpty){
        tempValidity = false;
      }
    });
    setState(() {
      areAllFieldsValid = tempValidity;
    });
  }

  void _clearAllFields() {}

  void _showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  TransformerModel _getTransformerData() {
    return TransformerModel(
      transformerName: transformerDataController[0].text.toString(),
      transformerSerialNumber: transformerDataController[1].text.toString(),
      feederName: transformerDataController[5].text.toString(),
      yCoordinates: transformerDataController[10].text.toString(),
      xCoordinates: transformerDataController[9].text.toString(),
      transformerCapacity: transformerDataController[2].text.toString(),
      isItPrivate: transformerDataController[4].text.toString() == "نعم" ? true : false,
      substationName: transformerDataController[6].text.toString(),
      zuqaqOrBlock: transformerDataController[8].text.toString(),
      mahlaOrSector: transformerDataController[7].text.toString(),
      isItOverhead: transformerDataController[3].text.toString() == "نعم" ? true : false,
    );
  }
}
