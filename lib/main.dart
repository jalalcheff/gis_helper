import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/data/database_service/adapters/latest_transformer_adapter.dart';
import 'package:gis_helper/data/database_service/adapters/transformer_resource_adapter.dart';
import 'package:gis_helper/data/database_service/database_service_imp.dart';
import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/repository/feeders_repository_imp.dart';
import 'package:gis_helper/data/repository/transformer_repository_imp.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/domain/feeders_repository.dart';
import 'package:gis_helper/domain/get_all_feeders_usecase.dart';
import 'package:gis_helper/domain/get_all_transformers_locally.dart';
import 'package:gis_helper/domain/get_all_transformers_number_usecase.dart';
import 'package:gis_helper/domain/transformer_repository.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TransformerResourceAdapter());
  Hive.registerAdapter(LatestTransformerAdapter());
  // Open any boxes you need (e.g., a box to store users)
  //await Hive.deleteBoxFromDisk('transformers');
  await Hive.openBox("transformer");
  await Hive.openBox("latest transformers");
  //((box.values.last as List)[0] as TransformerResource).printAllData();
  /* GetAllFeedersUsecase(
          feedersRepository: FeedersRepositoryImp(
              localDatabaseTransformers: DatabaseServiceImp()))
      .getAllFeeders();*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*TransformerRepositoryImp(
          databaseService: DatabaseServiceImp(), apiService: ApiServiceImp())
      .getLastChangesTransformers();
  FeedersRepositoryImp(localDatabaseTransformers: DatabaseServiceImp())
      .getAllFeeders();
  GetAllFeedersUsecase(
          feedersRepository: FeedersRepositoryImp(
              localDatabaseTransformers: DatabaseServiceImp()))
      .getAllFeeders();
  TransformerRepositoryImp(
          databaseService: DatabaseServiceImp(), apiService: ApiServiceImp())
      .getAllTransformers();*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StyleConstants styleConstants = StyleConstants();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Color(styleConstants.backgroundColor),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(styleConstants.colorBlack),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(styleConstants.mediumRadius.toDouble()),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              color: Color(styleConstants.colorBlack),
              fontSize: styleConstants.headLine4,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
            titleMedium: TextStyle(
              color: Color(styleConstants.colorBlack),
              fontSize: styleConstants.bodyFont,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),

            titleSmall: TextStyle(
              color: Color(styleConstants.colorGrey),
              fontSize: styleConstants.captionFont,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            )
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(styleConstants.colorWhite),
          )),
      home:  HomeScreen(),
    );
  }
}


/* ApiServiceImp().addTransformer(
        TransformerResource(
            feederName: "$countمثنى ",
            isItOverhead: false,
            isItPrivate: false,
            mahlaOrSector: "5",
            substationName: "المثنى ",
            transformerCapacity: "1000 kva",
            transformerName: "T123",
            transformerSerialNumber: "c3321",
            xCoordinates: "33.3342",
            yCoordinates: "44.44322",
            zuqaqOrBlock: "11"
        ),
      count.toString()
    );*/