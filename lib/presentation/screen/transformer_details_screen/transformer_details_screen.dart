import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/di/dependency_injection.dart';
import 'package:gis_helper/presentation/screen/data_edit_Screen/data_edit_screen.dart';
import 'package:gis_helper/presentation/screen/data_entry_screen/data_entry_screen.dart';
import 'package:gis_helper/presentation/screen/main_screen/collection_screen.dart';

import '../../../constants/style_constants.dart';
import '../../../data/resource/transformer_resource.dart';
import '../../cubit/delete_transformer_cubit/delete_transformer_cubit.dart';
import '../../cubit/update_all_transformers_cubit/update_all_transformers_cubit.dart';

class TransformerDetailsScreen extends StatefulWidget {
  const TransformerDetailsScreen(
      {super.key, required this.transformerDetails, required this.userRole});

  final TransformerResource transformerDetails;
  final String userRole;

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
    return BlocProvider(
      create: (context) => locator<DeleteTransformerCubit>(),
      child: Scaffold(
          body: TransformerDetailsScreenBody(),
        ),
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
                (widget.transformerDetails.isItOverhead)
                    ? "images/overhead.png"
                    : "images/kiosk.png",
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
              SizedBox(
                height: styleConstants.largeDp,
              ),
              if (widget.userRole == "admin")
                Column(
                  children: [
                    Divider(
                      color: Color(styleConstants.colorLightGrey),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: styleConstants.largeDp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          /*style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical : styleConstants.extraLargeDp))
                          ),
                            onPressed: () {},*/
                            child: MaterialButton(
                              color: Colors.red,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)
                             ),
                             padding: EdgeInsets.all(styleConstants.extraLargeDp),
                             onPressed: () {
                               _showDeleteConfirmationDialog(context);
                             },
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("حذف",
                                     style: Theme.of(context)
                                         .textTheme
                                         .titleLarge
                                         ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
                                 ),
                                 SizedBox(
                                   width: styleConstants.largeDp,
                                 ),
                                 Icon(
                                   Icons.delete,
                                   color: Colors.white,
                                 ),
                               ],
                             ),
                            )
                        ),
                        SizedBox(
                          width: styleConstants.largeDp,
                        ),
                        Expanded(
                            child: MaterialButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)
                              ),
                              padding: EdgeInsets.all(styleConstants.extraLargeDp),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DataEditScreen(transformerResource : widget.transformerDetails)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("تعديل",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(
                                    width: styleConstants.largeDp,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )/*Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text("حذف",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.white)
                                ),
                              ],
                            )*/),

                      ],
                    ),
                  ],
                ),
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
      child: Text(
          "${widget.transformerDetails.transformerSerialNumber} : رقم المحولة",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
    );
  }

  Container _buildTransformerInformationCards() {
    String isItOverhead =
        widget.transformerDetails.isItOverhead ? "محولة هوائية" : "محولة ارضية";
    String isItPrivate =
        widget.transformerDetails.isItPrivate ? "خاصة" : "حكومية";

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
                  "سعة المحولة",
                  widget.transformerDetails.transformerCapacity,
                  Icons.electric_bolt_sharp),
              _buildSingleTransformerInformationCard(
                  "اسم المغذي",
                  widget.transformerDetails.feederName,
                  Icons.electric_bolt_sharp),
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
              "اسم المحطة",
              widget.transformerDetails.substationName,
              Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "الموقع",
              "${getSectorOrMahala(widget.transformerDetails.mahlaOrSector)} / ${getSectorOrMahala(widget.transformerDetails.zuqaqOrBlock)}",
              Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(longitude) x الاحداثي",
              "${widget.transformerDetails.xCoordinates}",
              Icons.electric_bolt_sharp),
          SizedBox(
            height: styleConstants.largeDp,
          ),
          _buildSingleTransformerLocationInformationCard(
              "(latiitude) y الاحداثي",
              "${widget.transformerDetails.yCoordinates}",
              Icons.electric_bolt_sharp),
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
        padding: EdgeInsets.all(styleConstants.extraLargeDp),
        margin: EdgeInsets.symmetric(vertical: styleConstants.mediumDp),
        decoration: BoxDecoration(
          color: Color(styleConstants.colorLightGrey).withOpacity(0.3),
            borderRadius: BorderRadius.circular(styleConstants.extraLargeDp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                      fontWeight: FontWeight.bold, color: Colors.black),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ));
  }

  getSectorOrMahala(String mahlaOrSector) {
    if (mahlaOrSector.contains("قطاع") || mahlaOrSector.contains("بلوك")) {
      return mahlaOrSector.split(' ').reversed.join(' ');
    } else {
      return mahlaOrSector;
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (context) => locator<DeleteTransformerCubit>(),
          child: BlocListener<DeleteTransformerCubit, DeleteTransformerState>(
            listener: (context, state) {
              if (state is DeleteTransformerSuccess) {
                context.read<UpdateAllTransformersCubit>().loadAllTransformers();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CollectionScreen()));
              } else if (state is DeleteTransformerError) {
                Navigator.of(context).pop(); // إغلاق النافذة بدون حذف
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: AlertDialog(
              title: Text('تأكيد الحذف'),
              content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
              actions: [
                TextButton(
                  child: Text('لا'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // إغلاق النافذة بدون حذف
                  },
                ),
                BlocBuilder<DeleteTransformerCubit, DeleteTransformerState>(
                  builder: (context, state) {
                    if (state is DeleteTransformerLoading) {
                      return CircularProgressIndicator();
                    }
                    return TextButton(
                      child: Text('نعم' , style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red)),
                      onPressed: () async {
                        await context.read<DeleteTransformerCubit>().emitDeleteTransformer(widget.transformerDetails);
                        // نفّذ عملية الحذف هنا
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
