import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/general_constants.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/data/database_service/adapters/latest_transformer_adapter.dart';
import 'package:gis_helper/data/database_service/adapters/news_adapter.dart';
import 'package:gis_helper/data/database_service/adapters/transformer_resource_adapter.dart';
import 'package:gis_helper/data/database_service/database_service_imp.dart';
import 'package:gis_helper/data/repository/account_repository_imp.dart';
import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/repository/feeders_repository_imp.dart';
import 'package:gis_helper/data/repository/transformer_repository_imp.dart';
import 'package:gis_helper/data/resource/account_resource.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/domain/feeders_repository.dart';
import 'package:gis_helper/domain/get_all_feeders_usecase.dart';
import 'package:gis_helper/domain/get_all_transformers_locally.dart';
import 'package:gis_helper/domain/get_all_transformers_number_usecase.dart';
import 'package:gis_helper/domain/get_logindata_usecase.dart';
import 'package:gis_helper/domain/sign_in_usecase.dart';
import 'package:gis_helper/domain/transformer_repository.dart';
import 'package:gis_helper/presentation/cubit/add_transformer_cubit/add_transformer_cubit.dart';
import 'package:gis_helper/presentation/cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/delete_transformer_cubit/delete_transformer_cubit.dart';
import 'package:gis_helper/presentation/cubit/feeders_number_cubit/feeders_number_cubit.dart';
import 'package:gis_helper/presentation/cubit/get_image_documents_cubit.dart';
import 'package:gis_helper/presentation/cubit/image_document_cubit.dart';
import 'package:gis_helper/presentation/cubit/latest_changes_cubit/latest_changes_cubit.dart';
import 'package:gis_helper/presentation/cubit/sign_in_cubit/sign_in_cubit.dart';
import 'package:gis_helper/presentation/cubit/signout_cubit/signout_cubit.dart';
import 'package:gis_helper/presentation/cubit/update_all_transformers_cubit/update_all_transformers_cubit.dart';
import 'package:gis_helper/presentation/cubit/user_accountdata_cubit/user_accountdata_cubit.dart';
import 'package:gis_helper/presentation/screen/data_entry_screen/data_entry_screen.dart';
import 'package:gis_helper/presentation/screen/home_screen/home_screen.dart';
import 'package:gis_helper/presentation/screen/main_screen/collection_screen.dart';
import 'package:gis_helper/presentation/screen/search_screen/search_screen.dart';
import 'package:gis_helper/presentation/screen/sign_in_screen/sign_in_screen.dart';
import 'package:gis_helper/presentation/screen/splash_screen/splash_screen.dart';
import'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

import 'data/resource/result_pattern.dart';
import 'di/dependency_injection.dart';
import 'domain/get_Number_of_transformers_of_each_sector.dart';
import 'domain/search_for_transformers.dart';
import 'domain/signout_usecase.dart';
import 'firebase_options.dart';
import 'presentation/cubit/transformer_number_cubit/transformer_number_cubit.dart';
import 'presentation/cubit/transformer_number_of_each_sector_cubit/transformer_number_of_each_sector_cubit.dart';
import 'presentation/screen/transformer_details_screen/transformer_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TransformerResourceAdapter());
  Hive.registerAdapter(LatestTransformerAdapter());
  Hive.registerAdapter(NewsAdapter());
  // Open any boxes you need (e.g., a box to store users)
  //await Hive.deleteBoxFromDisk('transformers');
  await Hive.openBox("transformer");
  await Hive.openBox("latest transformers");
  await Hive.openBox("images");

  //((box.values.last as List)[0] as TransformerResource).printAllData();
  /* GetAllFeedersUsecase(
          feedersRepository: FeedersRepositoryImp(
              localDatabaseTransformers: DatabaseServiceImp()))
      .getAllFeeders();*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ar_SA', null); // Initialize Arabic locale

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
  await setUpLocator();
  runApp( 
      MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => locator<UserAccountdataCubit>(),
),
    BlocProvider(create: (context) => locator<FeedersNumberCubit>()),
    BlocProvider(create: (context) => locator<TransformerNumberCubit>()),
    BlocProvider(create: (context) => locator<AllTransformersCubit>()),
    BlocProvider(
        create: (context) =>
            locator<TransformerNumberOfEachSectorCubit>()),
    BlocProvider(
        create: (context) => locator<UpdateAllTransformersCubit>()),
    BlocProvider(
        create: (context) => locator<DeleteTransformerCubit>()),
    BlocProvider(create: (context) => locator<LatestChangesCubit>()),
    BlocProvider(create: (context) => locator<AddTransformerCubit>()),
    BlocProvider(create: (context) => locator<SignoutCubit>()),
    BlocProvider(create: (context) => locator<SignInCubit>()),
    BlocProvider(create: (context) => locator<ImageDocumentCubit>()),
    BlocProvider(create: (context) => locator<GetImageDocumentsCubit>())
  ],
  child: MyApp(),
));
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
   /* FirebaseAuth.instance.signOut().then((value){
      SignoutUsecase(accountRepository: locator<AccountRepositoryImp>()).signOut();
      print("current user ${FirebaseAuth.instance.currentUser?.uid.toString()}");
    });*/
    // Access the existing cubit instance from the context
    //context.read<UserAccountdataCubit>().emitUserAccountdata();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StyleConstants styleConstants = StyleConstants();
//    GetNumberOfTransformersOfEachSector(transformerRepository: TransformerRepositoryImp(databaseService: DatabaseServiceImp(), apiService: ApiServiceImp())).getNumberOfTransformersOfEachSector();
    return BlocBuilder<UserAccountdataCubit, UserAccountdataState>(
  builder: (context, state) {
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
      home: SplashScreen()
      /*switch(state) {
        UserAccountdataInitial() => Center(child: Lottie.asset("images/lottie.json")),
        UserAccountdataSuccess() => BlocProvider(
  create: (context) => locator<UserAccountdataCubit>(),
  child: CollectionScreen(),
),

      //  _userSignInScaffold(state.userAccountdata),
        UserAccountdataError() => BlocProvider(
            create: (context) => locator<SignInCubit>(),
            child: SignInScreen(),
          ),
      }*/
    );
  },
);
  }

}
