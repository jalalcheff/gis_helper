import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/list_and_maps.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/di/dependency_injection.dart';
import 'package:gis_helper/presentation/cubit/add_transformer_cubit/add_transformer_cubit.dart';


import '../../../domain/model/transformer_model.dart';

class DataEditScreen extends StatefulWidget {
  const DataEditScreen({super.key, required this.transformerResource});
final TransformerResource transformerResource;
  @override
  State<DataEditScreen> createState() => _DataEditScreenState();
}

class _DataEditScreenState extends State<DataEditScreen> {
  StyleConstants styleConstants = StyleConstants();
  late AddTransformerCubit _addTransformerCubit;
  Map<String, dynamic> transformerData = {
    "ارضية": "option1",
    "هوائية": "option2",
  };
  ListAndMaps transformersDataMaps = ListAndMaps();
  bool areAllFieldsValid = false;
  List<TextEditingController> transformerDataController =
  List.generate(11, (index) => TextEditingController());
  final TextEditingController transformerNameController =
  TextEditingController();
  final TextEditingController transformerNumberController =
  TextEditingController();
  final TextEditingController feederNameController = TextEditingController();
  final TextEditingController transformerXController = TextEditingController();
  final TextEditingController transformerYController = TextEditingController();
  final TextEditingController transformerCapacity = TextEditingController();
  final TextEditingController isItOverheadTransformerController =
  TextEditingController();
  final TextEditingController isItOwnedTransformerController =
  TextEditingController();
  final TextEditingController substationNameController =
  TextEditingController();
  final TextEditingController zuqaqOrBlockController = TextEditingController();
  final TextEditingController mahalaOrSectorController =
  TextEditingController();

  @override
  void initState() {
    print("data to be modified feeder : ${widget.transformerResource.feederName} % subs : ${widget.transformerResource.substationName}");
    _addTransformerCubit = locator<AddTransformerCubit>();
    transformerDataController[0].text = widget.transformerResource.transformerName;
    transformerDataController[1].text = widget.transformerResource.transformerSerialNumber;
    transformerDataController[2].text = widget.transformerResource.transformerCapacity;
    transformerDataController[3].text = widget.transformerResource.isItOverhead ? "نعم" : "لا";
    transformerDataController[4].text = widget.transformerResource.isItPrivate ? "نعم" : "لا";
    transformerDataController[5].text = widget.transformerResource.feederName;
    transformerDataController[6].text = widget.transformerResource.substationName;
    transformerDataController[7].text = widget.transformerResource.mahlaOrSector;
    transformerDataController[8].text = widget.transformerResource.zuqaqOrBlock;
    transformerDataController[9].text = widget.transformerResource.xCoordinates;
    transformerDataController[10].text = widget.transformerResource.yCoordinates;
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
                _textFormField(
                    "اسم المحولة", transformerDataController[0], "T155"),
                SizedBox(height: styleConstants.mediumDp),
                _textFormField(
                    "رقم المحولة", transformerDataController[1], "1221"),
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "سعة المحولة",
                    transformersDataMaps.transformerCapacity,
                    transformerDataController[2]
                ), //drop down
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "هل هي محولة هوائية ؟",
                    transformersDataMaps.transformerYesOrNo,
                    transformerDataController[3]), //drop down
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "هل هي محولة خاصة ؟",
                    transformersDataMaps.transformerYesOrNo,
                    transformerDataController[4]), //drop down),  //drop down
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "اسم المغذي",
                    transformersDataMaps.feedersName,
                    transformerDataController[5]), //drop down
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "اسم المحطة",
                    transformersDataMaps.substationName,
                    transformerDataController[6]), //drop down
                SizedBox(height: styleConstants.extraLargeDp),
                _transformerDataDropdownMenu(
                    "محلة او قطاع",
                    transformersDataMaps.transformerMahalaOrSector,
                    transformerDataController[7]), //drop down
                SizedBox(height: styleConstants.mediumDp),
                _transformerDataDropdownMenu(
                    "زقاق او بلوك",
                    transformersDataMaps.transformerZuqaqOrBlock,
                    transformerDataController[8]), //drop down
                SizedBox(height: styleConstants.mediumDp),
                _textFormField(
                    "X الاحداثي", transformerDataController[9], "44.4421"),
                SizedBox(height: styleConstants.mediumDp),
                _textFormField(
                    "Y الاحداثي", transformerDataController[10], "33.33212"),
                // Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      vertical: styleConstants.extraLargeDp),
                  alignment: Alignment.bottomCenter,
                  child: BlocListener<AddTransformerCubit, AddTransformerState>(
                    listener: (context, state) {
                      if (state is AddTransformerLoaded) {
                        _clearAllFields();
                        _showSnackBar(context, "تم إضافة المحولة بنجاح");
                      } else if (state is AddTransformerError) {
                        _showSnackBar(context, "حدث خطأ أثناء إضافة المحولة");
                      }
                    },
                    child: MaterialButton(
                      onPressed: !areAllFieldsValid
                          ? () {}
                          : () {
                        final TransformerModel transformer =
                        _getTransformerData();
                        _addTransformerCubit.addTransformer(transformer,
                            "${transformer.transformerName} ${transformer.transformerSerialNumber}");
                        print(
                            "data inside transformer capacity ${transformerDataController[2].text}");
                      },
                      color: areAllFieldsValid
                          ? Color(styleConstants.colorBlack)
                          : Colors.grey[600],
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: styleConstants.extraLargeDp),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              styleConstants.extraLargeDp)),
                      child: Text(
                        "اضافة المحولة",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Color(styleConstants.colorWhite)),
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

  Column _textFormField(
      String label, TextEditingController controller, String hint) {
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
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Color(styleConstants.colorBlack).withOpacity(0.35)),
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

  Column _transformerDataDropdownMenu(String title, Map<String, dynamic> data,
      TextEditingController controller) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black),
            )),
        SizedBox(height: styleConstants.smallDp),
        DropdownMenu(
            controller: controller,
            textAlign: TextAlign.end,
            menuStyle: MenuStyle(
                backgroundColor:
                WidgetStatePropertyAll(Color(styleConstants.colorWhite)),
                side: WidgetStatePropertyAll(BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp,
                ))),
            width: MediaQuery.of(context).size.width,
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(styleConstants.extraLargeDp),
                borderSide: BorderSide(
                    color: Color(styleConstants.colorLightGrey),
                    width: styleConstants.smallDp),
              ),
            ),
            initialSelection: controller.text,
            dropdownMenuEntries: data
                .map((key, value) =>
                MapEntry(key, DropdownMenuEntry(value: value, label: key)))
                .values
                .toList()),
      ],
    );
  }

  void _checkValidity() {
    bool tempValidity = true;
    transformerDataController.forEach((transformerDataController) {
      if (transformerDataController.text.trim().isEmpty) {
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
      isItPrivate:
      transformerDataController[4].text.toString() == "نعم" ? true : false,
      substationName: transformerDataController[6].text.toString(),
      zuqaqOrBlock: transformerDataController[8].text.toString(),
      mahlaOrSector: transformerDataController[7].text.toString(),
      isItOverhead:
      transformerDataController[3].text.toString() == "نعم" ? true : false,
    );
  }
}
